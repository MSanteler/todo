class Task < ActiveRecord::Base

  belongs_to :user

  has_many :tasklets, :dependent => :destroy
  has_many :subtasks, :through => :tasklets, :dependent => :destroy

  # Trace parent task
  has_one :parental_tasklet, class_name: "Tasklet", foreign_key: :subtask_id
  has_one :parental_task, :through => :parental_tasklet, :source => :task

  accepts_nested_attributes_for :parental_tasklet, :allow_destroy => true

  scope :root_tasks, -> {
  	where("NOT EXISTS (SELECT 'id' from tasklets where tasklets.subtask_id = tasks.id)")
	}

	validates :user_id, :presence => true

  def associate_with_parent(parent_task)
  	if parental_tasklet
  		if parental_tasklet.persisted?
  			parental_tasklet.destroy
			elsif @parental.try(:task) == parent_task
				parental_tasklet.save
			end
		else
			parent_task.subtasks << self
		end
  end

end
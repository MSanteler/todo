class Tasklet < ActiveRecord::Base

  belongs_to :task
  belongs_to :subtask, :class_name => 'Task'

  # subtask cannot belong to more than 1 parent task
  validates :subtask_id, :uniqueness =>  true

end

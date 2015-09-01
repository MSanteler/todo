class Task < ActiveRecord::Base

  belongs_to :user

  has_many :tasklets
  has_many :subtasks, :through => :tasklets

end
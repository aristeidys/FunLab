class Task < ApplicationRecord
  belongs_to :labsession
  
  has_many :task_results
  has_many :students, through: :task_results

  scope :title, -> (title) { where title: title }
end

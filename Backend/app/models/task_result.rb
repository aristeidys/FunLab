class TaskResult < ApplicationRecord

  belongs_to :student
  belongs_to :task
  validates :student_id, uniqueness: { scope: :task_id,
    message: "Each task result should be unique" }
  scope :findByStudentID, -> (student_id) { where student_id: student_id }
  
end
    
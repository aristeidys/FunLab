class TaskResult < ApplicationRecord

  belongs_to :student
  belongs_to :task

  scope :findByParentID, -> (student_id) { where student_id: student_id }

end
    
class Enrollment < ApplicationRecord
    belongs_to :classroom
    belongs_to :student
    validates :student_id, uniqueness: { scope: :classroom_id,
      message: "Each enrollment should be unique" }
    after_initialize :init

    scope :findBy, -> (classroom_id, student_id) { where classroom_id: classroom_id, student_id: student_id }

    def init
      self.isApproved  ||= false
    end
end
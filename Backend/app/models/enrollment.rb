class Enrollment < ApplicationRecord
    belongs_to :classroom
    belongs_to :student

    after_initialize :init

    def init
      self.isApproved  ||= false
    end
end
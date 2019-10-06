
class ClassroomEnrollments < ApplicationRecord
    belongs_to :session
    belongs_to :student
end
      
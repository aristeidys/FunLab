class Enrolment < ApplicationRecord
    belongs_to :student
    belongs_to :lab_session
end

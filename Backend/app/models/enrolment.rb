class Enrolment < ApplicationRecord
    belongs_to :students
    belongs_to :labSessions
end

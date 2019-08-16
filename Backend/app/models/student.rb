class Student < ApplicationRecord
    has_many :enrollments
    has_many :labSessions, :through => :enrollments
end

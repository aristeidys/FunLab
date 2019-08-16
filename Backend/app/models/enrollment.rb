class Enrollment < ApplicationRecord
    belongs_to :studnets
    belongs_to :labSessions
end

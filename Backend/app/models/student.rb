class Student < ApplicationRecord

    validates :name, uniqueness: true

    has_many :enrolments
    has_many :lab_sessions, :through => :enrolments

    # Search
    scope :findByName, -> (name) { where name: name }
end

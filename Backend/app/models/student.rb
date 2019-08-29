class Student < ApplicationRecord

    validates :name, uniqueness: true

    has_many :enrollments
    has_many :students, :through => :enrollments  

    # Search
    scope :findByName, -> (name) { where name: name }

    include PgSearch::Model
    pg_search_scope :search_by_name, against: :name,
    using: {
    tsearch: {
    prefix: true
        }
    }
end

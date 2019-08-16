class LabSession < ApplicationRecord
  has_many :activities
  has_many :enrollments
  has_many :students, :through => :enrollments

  scope :title, -> (title) { where title: title }
  
  # Search

  include PgSearch
  pg_search_scope :search_by_title, against: :title,
  using: {
  tsearch: {
  prefix: true
        }
      }
end

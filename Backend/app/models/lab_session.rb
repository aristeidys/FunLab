class LabSession < ApplicationRecord
  validates :title, uniqueness: true

  has_many :activities
  has_many :enrolments
  has_many :students, :through => :enrolments

  
  # Search
  scope :findByTitle, -> (title) { where title: title }

  include PgSearch
  pg_search_scope :search_by_title, against: :title,
  using: {
  tsearch: {
  prefix: true
        }
      }
end

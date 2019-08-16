class Activity < ApplicationRecord
  belongs_to :lab_session
  
  scope :title, -> (title) { where title: title }

  # Search

  include PgSearch
  pg_search_scope :search_by_lab_session_id, against: :lab_session_id,
  using: {
  tsearch: {
  prefix: true
        }
      }
end

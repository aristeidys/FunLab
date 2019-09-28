class LabSession < ApplicationRecord
  validates :title, uniqueness: true

  has_many :activities
  
  # Search
  scope :findByTitle, -> (title) { where title: title }
end

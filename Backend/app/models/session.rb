class Session < ApplicationRecord
  validates :title, uniqueness: true
  
  belongs_to :module
  
  has_many :tasks
  
  has_many :session_results
  has_many :students, through: :session_results

  # Search
  scope :findByTitle, -> (title) { where title: title }
end

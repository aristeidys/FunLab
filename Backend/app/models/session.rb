class Session < ApplicationRecord
  
  # Validations
  validates :name, uniqueness: true
  
  # Relations
  belongs_to :classroom
  has_many :tasks
  
  has_many :session_results
  has_many :students, through: :session_results

  # Search
  scope :findByName, -> (name) { where name: name }
end

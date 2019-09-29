class Labsession < ApplicationRecord
  
  # Validations
  validates :name, uniqueness: true
  
  # Relations
  belongs_to :classroom
  has_many :tasks
  
  has_many :labsession_results
  has_many :students, through: :labsession_results

  # Search
  scope :findByName, -> (name) { where name: name }
end

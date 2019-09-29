class Classroom < ApplicationRecord

  # Validations
  validates :name, :length => { :in => 6..30 }
  validates :name, uniqueness: true
  validates :name, presence: true

  # Search
  scope :findByName, -> (name) { where name: name }

  # Relations
  belongs_to :instructor
    
  has_many :labsessions
end
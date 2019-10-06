class Instructor < ApplicationRecord
      
  # Validations
  # validates :name, :length => { :in => 3..25 }
  validates :username, :length => { :in => 6..20 }
  # validates :password, :length => { :in => 8..20 }
  validates :username, uniqueness: true
  # validates :name, :username, :password, presence: true
  validates :username, presence: true

  # Search
  scope :findByUsername, -> (username) { where username: username }

  # Relations
  has_many :classrooms
end
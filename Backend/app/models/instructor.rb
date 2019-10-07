class Instructor < ApplicationRecord
      
  # Validations
  validates :name, :length => { :in => 6..40 }
  validates :username, :length => { :in => 6..40 }
  validates :password, :length => { :in => 8..40 }
  validates :username, uniqueness: true
  validates :name, :username, :password, presence: true

  # Search
  scope :findByUsername, -> (username) { where username: username }

  # Relations
  has_many :classrooms
end
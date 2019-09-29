class Instructor < ApplicationRecord
      
  #Validations
  validates :name, :length => { :in => 3..15 }
  validates :username, :length => { :in => 6..15 }
  validates :password, :length => { :in => 8..15 }
  validates :name, :presence => true
  validates :username, uniqueness: true
  validates :name, :username, :password, :presence => true

  # Search
  scope :findByUsername, -> (username) { where username: username }

  # Relations
  has_many :modules
end
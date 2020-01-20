class Instructor < ApplicationRecord
      
  # Validations
  validates :name, :length => { :in => 4..45 }
  validates :email, :length => { :in => 6..40 }
  validates :password, :length => { :in => 8..40 }

  validates :name, :email, :password, 
  validates :email, uniqueness: true
  validates :email, presence: true
  
  # Search
  scope :findByEmail, -> (email) { where email: email }

  # Relations
  has_many :classrooms
end
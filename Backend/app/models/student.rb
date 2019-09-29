class Student < ApplicationRecord
  
  # Validations
  validates :name, :length => { :in => 3..15 }
  validates :username, :length => { :in => 6..15 }
  validates :password, :length => { :in => 8..15 }
  validates :username, uniqueness: true
  validates :name, :username, :password, presence: true

  # Search
  scope :findByUsername, -> (username) { where username: username }

  # Relations
  has_many :labsession_results
  has_many :labsessions, through: :labsession_results

  has_many :task_results
  has_many :tasks, through: :task_results
end

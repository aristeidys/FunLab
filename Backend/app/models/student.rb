class Student < ApplicationRecord
  
  # Validations
  validates :name, :length => { :in => 3..25 }
  validates :username, :length => { :in => 6..20 }
  validates :password, :length => { :in => 8..20 }
  validates :username, uniqueness: true
  validates :name, :username, :password, presence: true

  # Search
  scope :findByUsername, -> (username) { where username: username }

  # Relations
  has_many :session_results
  has_many :sessions, through: :session_results

  has_many :task_results
  has_many :tasks, through: :task_results

  has_many :enrollments
  has_many :classrooms, through: :enrollments
end

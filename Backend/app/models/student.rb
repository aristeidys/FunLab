class Student < ApplicationRecord
      
  # Validations
  validates :name, :length => { :in => 4..45 }
  validates :email, :length => { :in => 6..40 }
  validates :password, :length => { :in => 8..40 }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true

  # Search
  scope :findByEmail, -> (email) { where email: email }

  # Relations
  has_many :session_results
  has_many :sessions, through: :session_results

  has_many :task_results
  has_many :tasks, through: :task_results

  has_many :enrollments
  has_many :classrooms, through: :enrollments
end

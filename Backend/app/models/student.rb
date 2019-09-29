class Student < ApplicationRecord
  
  validates :name, :length => { :in => 3..15 }
  validates :username, :length => { :in => 6..15 }
  validates :password, :length => { :in => 8..15 }
  validates :name, :presence => true
  validates :username, uniqueness: true
  
  validates :name, :username, :password, :presence => true

  has_many :session_results
  has_many :sessions, through: :session_results

  has_many :task_results
  has_many :tasks, through: :task_results

  # Search
  scope :findByUsername, -> (username) { where username: username }
end

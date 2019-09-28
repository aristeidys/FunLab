class Student < ApplicationRecord

#    validates :name, uniqueness: true

  has_many :session_results
  has_many :sessions, through: :session_results

  has_many :task_results
  has_many :tasks, through: :task_results

  # Search
  scope :findByName, -> (name) { where name: name }
end

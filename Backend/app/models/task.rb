class Task < ApplicationRecord

  # Validations
  validates :name, :length => { :in => 3..30 }
  validates :name, presence: true
  validates :difficulty, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10,  only_integer: true }

  # Search
  scope :findByName, -> (name) { where name: name }
  scope :findBySessionID, -> (session_id) { where session_id: session_id }

  # Relations
  belongs_to :session  
  has_many :task_results
  has_many :students, through: :task_results
end

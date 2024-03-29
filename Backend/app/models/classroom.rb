class Classroom < ApplicationRecord

  # Validations
  validates :name, :length => { :in => 6..30 }
  validates :name, uniqueness: true
  validates :name, presence: true

  # Search
  scope :findByName, -> (name) { where name: name }
  scope :findByParentID, -> (instructor_id) { where instructor_id: instructor_id }

  # Relations
  belongs_to :instructor
    
  has_many :sessions

  has_many :enrollments
  has_many :students, through: :enrollments
end
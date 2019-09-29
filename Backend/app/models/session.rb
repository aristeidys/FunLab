class Session < ApplicationRecord
  
  # Validations
  validates :name, uniqueness: true
  
  after_initialize :init

  def init
    self.isActive = false if self.isActive.nil?
  end

  # Relations
  belongs_to :classroom
  has_many :tasks
  
  has_many :session_results
  has_many :students, through: :session_results

  # Search
  scope :findByName, -> (name) { where name: name }
end

class Session < ApplicationRecord
    
  after_initialize :init
  
  validates :status, inclusion: { in: %w(draft active archived),

  def init
    self.status  ||= 'draft'
  end

  # Search
  scope :findBytitle, -> (title) { where title: title }
  scope :findByParentID, -> (classroom_id) { where classroom_id: classroom_id }

  # Relations
  belongs_to :classroom
  has_many :tasks
  
  has_many :session_results
  has_many :students, through: :session_results
end

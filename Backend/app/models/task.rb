class Task < ApplicationRecord

  # Validations
  validates :name, :length => { :in => 6..30 }
  #validates :name, uniqueness: true
  validates :name, presence: true

  after_initialize :init

    def init
      self.difficulty  ||= 0
    end

  # Search
  scope :findByName, -> (name) { where name: name }

  belongs_to :session
  
  has_many :task_results
  has_many :students, through: :task_results

  scope :title, -> (title) { where title: title }
end

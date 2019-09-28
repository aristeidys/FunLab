class Activity < ApplicationRecord
  belongs_to :lab_session
  
  scope :title, -> (title) { where title: title }
end

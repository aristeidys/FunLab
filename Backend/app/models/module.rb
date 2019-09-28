class Module < ApplicationRecord
    belongs_to :instructor
    
    has_many :sessions
end



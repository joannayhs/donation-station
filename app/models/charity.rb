class Charity < ActiveRecord::Base 
    has_many :donations
    belongs_to :users
end 
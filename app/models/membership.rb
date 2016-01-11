class Membership < ActiveRecord::Base
	belongs_to :gym
	belongs_to :user
	
  # validates_with DefaultValidator
end

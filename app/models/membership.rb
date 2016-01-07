class Membership < ActiveRecord::Base
	belongs_to :gym
	belongs_to :user
	
end

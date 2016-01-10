class Gym < ActiveRecord::Base
	has_many :workouts 
	has_many :memberships
	has_many :users, :through => :memberships



	def name_and_url
		"#{name} (#{workout_url})"
	end

	def self.default
  		find_by(default: true)
	end
end

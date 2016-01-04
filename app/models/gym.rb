class Gym < ActiveRecord::Base
	has_many :workouts 
	belongs_to :user

	def name_and_url
		"#{name} (#{workout_url})"
	end
end

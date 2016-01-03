class Gym < ActiveRecord::Base
	has_many :workouts 

	def name_and_url
		"#{name} (#{workout_url})"
	end
end

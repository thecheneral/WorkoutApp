class Gym < ActiveRecord::Base
	has_many :workouts 
	belongs_to :user

validates :default, uniqueness:{ scope: :user,
			message: "Only one default gym per user."}

	def name_and_url
		"#{name} (#{workout_url})"
	end

	def self.default
  		find_by(default: true)
	end
end

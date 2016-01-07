class Gym < ActiveRecord::Base
	has_many :workouts 
	has_many :memberships
	has_many :users, :through => :memberships

# validates :default, uniqueness:{ scope: :user,
# 			message: "Only one default gym per user."}

	def name_and_url
		"#{name} (#{workout_url})"
	end

	def self.default
  		find_by(default: true)
	end
end

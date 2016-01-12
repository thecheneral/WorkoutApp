class Gym < ActiveRecord::Base
	has_many :workouts 
	has_many :memberships
	has_many :users, :through => :memberships

  validates :name, :workout_url, presence: { strict: true }

  has_many :default_for_user, -> { default }, :class_name => 'Membership'
  

end
class Gym < ActiveRecord::Base
	has_many :workouts 
	has_many :memberships
	has_many :users, :through => :memberships

  validates :name, :workout_url, presence: true

  has_many :default_for_users, -> { default }, :class_name => 'Membership'
  
  def find_default (gym)
    Membership.find_by(gym_id: gym).default
  end

end
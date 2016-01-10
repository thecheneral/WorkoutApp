class Membership < ActiveRecord::Base
	belongs_to :gym
	belongs_to :user
	
  validates :default, uniqueness:{ scope: :user_id,
      message: "Only one default gym per user."}
end

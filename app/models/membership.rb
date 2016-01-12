class Membership < ActiveRecord::Base
	belongs_to :gym
	belongs_to :user
	
  scope :default, -> { where(:default => true) }

  validates_with DefaultValidator
end

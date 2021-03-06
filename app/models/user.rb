class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :workouts
  has_many :memberships
  has_many :gyms, :through => :memberships 

  has_many :default_gyms, -> { default }, :class_name => 'Membership'

end

class GymsController < ApplicationController
	def show
		@gym = Gym.where(id: params[:id]).includes(:workouts).first
	end

	def index
		@gyms = Gym.all
	end
end

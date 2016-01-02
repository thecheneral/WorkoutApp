class GymsController < ApplicationController
	def show
		@gym = Gym.where(id: params[:id]).includes(:workouts).first
	end
end

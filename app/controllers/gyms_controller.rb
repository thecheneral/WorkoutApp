class GymsController < ApplicationController
	
	def index
		@gyms = Gym.all
	end

	def create
		
	end

	def new
		
	end

	def show
		@gym = Gym.where(id: params[:id]).includes(:workouts).first
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end
end

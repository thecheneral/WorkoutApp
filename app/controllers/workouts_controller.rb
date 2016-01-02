class WorkoutsController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :new, :create, :show, :edit, :udpate, :destroy ]
	def show
    @search = params[:search]

	    if @search
	    	@workout = Workout.search(@search)

	    elsif params[:id] == "all"
	    	@workouts = Workout.all
	    else
	    	@workouts = Workout.find(params[:id])
	    end
    	  
	end

	def create
		
	end

	def new
		
	end

	def edit
		
	end

	def update
		
	end

	def destroy
		
	end
end

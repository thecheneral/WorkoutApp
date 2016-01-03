class WorkoutsController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :new, :create, :show, :edit, :udpate, :destroy ]
	
	def index
		@search = params[:search]

	    if @search
	    	@workouts = Workout.search(@search)

	    elsif params[:id] == "all"
	    	@workouts = Workout.all
	    else
	    	@workouts = Workout.find(params[:id])
	    end
		
	end

	def new
		@workout = Workout.new
	end
	
	def create
		@workout = current_user.workouts.build workout_params
		# @workout.gym = Gym.find_or_create_by(name:params[:gym])

		if @workout.save
			flash[:notice] = "Workout created."
			redirect_to edit_workout_path(@workout)
		else
      		flash.now[:alert] = @workout.errors.first
      		render 'new'
      	end
	end

	def edit
		@workout = Workout.find(params[:id])
	end

	def show
		@workout = Workout.find(params[:id])
	end
	
	def update
		@workout = Workout.find(params[:id])
		if @workout.update(workout_params)
			redirect_to workout_path(@workout)
		else
      		flash.now[:error] = @workout.errors.messages.first.join(" ")
      		render 'edit'
      	end
	end

	def destroy
		@workout = workout.find(params[:id])
    	@workout.destroy
    	redirect_to workouts_path
	end

	private

	def workout_params
		params.require(:workout).permit(:workout_datetime, :gym_id)
	end
end

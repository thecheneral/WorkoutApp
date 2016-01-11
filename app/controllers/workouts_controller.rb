class WorkoutsController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		@search = params[:search]

	    if @search
	    	@workouts = current_user.workouts.search(@search)
	    	@workouts = @workouts.sort_by(&:workout_datetime).reverse

	    elsif params[:id] == "all"
	    	@workouts = current_user.workouts.all
	    	@workouts = @workouts.sort_by(&:workout_datetime).reverse
	    else
	    	@workouts = current_user.workouts.find(params[:id])
	    	@workouts = @workouts.sort_by(&:workout_datetime).reverse
	    end
		
	end

	def new
		@workout = current_user.workouts.new
	end
	
	def create
		@workout = current_user.workouts.build workout_params
		# @workout.gym = Gym.find_or_create_by(name:params[:gym])

		if @workout.save
			flash[:notice] = "Workout fetched for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}."
			redirect_to edit_workout_path(@workout)
		else
      		flash.now[:alert] = @workout.errors.first
      		render 'new'
      	end
	end

	def edit
		@workout = Workout.find(params[:id])
		if @workout.description.nil? || @workout.description.empty?
			@workout_scrape = @workout.get_gym_feed(@workout.gym.workout_url,@workout.workout_datetime)
			@workout.description = @workout_scrape

			@fitbit_hr = @workout.get_fitbit_hr_data(@workout.workout_datetime,current_user)
			@data = (@fitbit_hr)
			@hr_minute_data = @data["activities-heart-intraday"]["dataset"]
			@workout.update_attribute(:fitbit_heart_rate, @hr_minute_data)
			flash[:notice] = "Description and FitBit Heart Rate Data added for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}."
		end
	end

	def show
		@workout = Workout.find(params[:id])
		# @data = eval(@workout.fitbit_heart_rate)
		# @time = @data.map{|time| time["time"]}
		# @heart_rate = @data.map{|value| value["value"]}
		# @workout = {:workout => @workout, :time => @time, :heart_rate => @heart_rate}
	end
	
	def update
		@workout = Workout.find(params[:id])
		if @workout.update(update_params)
			redirect_to workout_path(@workout)
		else
      flash.now[:error] = @workout.errors.messages.first.join(" ")
      render 'edit'
    end
	end

	def destroy
		@workout = Workout.find(params[:id])
    @workout.destroy
		flash[:notice] = "Workout on #{@workout.workout_datetime.strftime("%B %d, %Y")} deleted."
    redirect_to workouts_path(id: "all")
	end

	private

	def workout_params
		params.require(:workout).permit(:workout_datetime, :gym_id)
	end

	def update_params
		params.require(:workout).permit(:description, :result, :lift_type, :lift_weight, :lift_rep_scheme)
	end
end

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
			redirect_to edit_workout_path(@workout)
		else
			flash.now[:alert] = @workout.errors[:alert].join(" ")
      render 'new'
    end
	end

	def edit
		#pull id of a workout creation redirected from create
		@workout = Workout.find(params[:id])

		#if the description is blank - scrape it.
		if @workout.description.nil? || @workout.description.empty?
			#need error handling here
			@workout_scrape = @workout.get_gym_feed(@workout.gym.workout_url,@workout.workout_datetime)
			@workout.update_attribute(:description, @workout_scrape)
			notice = ["Description added for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}."]
		end
		
		#begin pulling fitbit data, but if there's no access token or expiration than flash message and end
		if current_user.access_token.nil? || current_user.expires_at.nil?
			notice = notice.push("\nFitBit needs to be authenticated to get HR data.")
			flash[:notice] = notice.join
		#everything should be good to go so returning fitbit HR data
		elsif @workout.fitbit_heart_rate.nil? || @workout.fitbit_heart_rate.empty?
			@fitbit_hr = @workout.get_fitbit_hr_data(@workout.workout_datetime,current_user)
			@data = @fitbit_hr
			@hr_minute_data = @data["activities-heart-intraday"]["dataset"]
			@workout.update_attribute(:fitbit_heart_rate, @hr_minute_data)
			notice = notice.push("\nFitBit Heart Rate Data added for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}.")
			flash[:notice] = notice.join
		end
	end

	def show
		@workout = Workout.find(params[:id])
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

	def fitbit
		@workout = Workout.find(params[:id])
		#begin pulling fitbit data, but if there's no access token or expiration than flash message and end
		if current_user.access_token.nil? || current_user.expires_at.nil?
			notice = notice.push("\nFitBit needs to be authenticated to get HR data.")
			flash[:notice] = notice.join
		#everything should be good to go so returning fitbit HR data
		elsif @workout.fitbit_heart_rate.nil? || @workout.fitbit_heart_rate.empty?
			@fitbit_hr = @workout.get_fitbit_hr_data(@workout.workout_datetime,current_user)
			@data = @fitbit_hr
			@hr_minute_data = @data["activities-heart-intraday"]["dataset"]
			@workout.update_attribute(:fitbit_heart_rate, @hr_minute_data)
			notice = notice.push("\nFitBit Heart Rate Data added for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}.")
			flash[:notice] = notice.join
		else
		end
		redirect_to workout_path(@workout) #goes back to the show
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

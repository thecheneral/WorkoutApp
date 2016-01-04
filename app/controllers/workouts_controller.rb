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
			flash[:notice] = "Workout fetched for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}."
			redirect_to edit_workout_path(@workout)
		else
      		flash.now[:alert] = @workout.errors.first
      		render 'new'
      	end
	end

	def edit
		# @workout = Workout.find(params[:id])
		# @workout_scrape = WorkoutScraper.new(@workout.gym.workout_url,@workout.workout_datetime)
		# @workout_scrape = @workout_scrape.get_gym_feed
		# @workout.description = @workout_scrape.get_class_items
		require 'nokogiri'
		require 'open-uri'

		@workout = Workout.find(params[:id])
		@url = @workout.gym.workout_url
		@date = "#{@workout.workout_datetime.month}#{@workout.workout_datetime.day}#{@workout.workout_datetime.year.to_s.split(//).last(2).join}"
		
		@wod_from_site = Nokogiri::HTML(open("#{@url}#{@date}/"))
		#would need to pass the date for the specific feed and would need to pass the specific date
		@scrape = @wod_from_site.css('div.entry-content')[0].css('p').map{|p| p.children.first.text}
		@scrape.drop(1)

		# @scrape.each do |line|
		# 	 = line
		# end
		@workout.description = @scrape.join("/n")
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

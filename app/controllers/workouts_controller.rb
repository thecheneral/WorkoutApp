class WorkoutsController < ApplicationController
	before_filter :authenticate_user!, only: [:index, :new, :create, :show, :edit, :udpate, :destroy ]
	
	def index
		@search = params[:search]

	    if @search
	    	@workouts = current_user.workouts.search(@search)

	    elsif params[:id] == "all"
	    	@workouts = current_user.workouts.all
	    else
	    	@workouts = current_user.workouts.find(params[:id])
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
			@fitbit = @workout.get_fitbit_data(@workout.workout_datetime,current_user)
			flash[:notice] = "Description added for #{@workout.workout_datetime.to_date.to_formatted_s(:long_ordinal)}."
		else
			flash[:notice] = "Awaiting updates..."
		end
		# require 'nokogiri'
		# require 'open-uri'

		# @workout = Workout.find(params[:id])
		# @url = @workout.gym.workout_url
		# @date = "#{@workout.workout_datetime.month}#{@workout.workout_datetime.day}#{@workout.workout_datetime.year.to_s.split(//).last(2).join}"
		
		# @wod_from_site = Nokogiri::HTML(open("#{@url}#{@date}/"))
		# #would need to pass the date for the specific feed and would need to pass the specific date
		# @scrape = @wod_from_site.css('div.entry-content')[0].css('p').map{|p| p.children.first.text}
		# @scrape.drop(1)

		# # @scrape.each do |line|
		# # 	 = line
		# # end
		# @workout.description = @scrape.join("<p>")
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

	def destroy
		@workout = Workout.find(params[:id])
    @workout.destroy
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

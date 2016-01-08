class GymsController < ApplicationController
	
	def index
		@gyms = current_user.gyms.all
	end

	def new
		@gym = current_user.gyms.new
	end

  def create
    @gym = current_user.gyms.build gym_params

    # @workout.gym = Gym.find_or_create_by(name:params[:gym])

    if @gym.save
      @membership = current_user.memberships.build(gym_id: @gym.id, default: gym_params[:default] == '1')
      @membership.save
      flash[:notice] = "Gym created."
      redirect_to gym_path(@gym)
    else
      flash.now[:alert] = @gym.errors.first
      render 'new'
    end    
  end

	def show
		@gym = Gym.find(params[:id])
    @workouts = current_user.workouts.where(gym: @gym)
	end

	def edit
		
	end

	def update
		
	end

	def destroy
    @gym = Gym.find(params[:id])
    @gym.destroy
    redirect_to gyms_path
	end

  private

  def gym_params
    params.require(:gym).permit(:name, :workout_url, :default)
  end
end
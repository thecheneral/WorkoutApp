class GymsController < ApplicationController
before_filter :authenticate_user!	
	def index
		@gyms = current_user.gyms
	end

	def new
		@gym = current_user.gyms.new
	end

  def create
    membership_default = params["gym"]["memberships"][:default]
    @gym = Gym.find_or_create_by(name:gym_params[:name], workout_url:gym_params[:workout_url])
    @membership = current_user.memberships.build(user_id: current_user.id, gym_id: @gym.id, default: membership_default == '1')

    if @membership.save
      if @gym.save
        flash[:notice] = "Gym created."
        redirect_to gym_path(@gym)
      else
        flash.now[:error] = @gym.errors.messages.first.join(" ")
      end
    else
      flash.now[:alert] = @membership.errors[:alert].join(" ")
      render 'new'
    end    
  end

	def show
		@gym = current_user.gyms.find(params[:id])
    @workouts = current_user.workouts.where(gym: @gym)
	end

	def edit
		@gym = current_user.gyms.find(params[:id])
	end

	def update
    membership_default = params["gym"]["memberships"][:default]
    @gym = current_user.gyms.find(params[:id])
		if @gym.update(gym_params)
      @membership = Membership.find(gym_id: @gym.id, user_id: current_user.id)
      @membership.update(gym_id: @gym_id, default: membership_default == '1')
      flash[:notice] = "Gym updated."
      redirect_to gym_path(@gym)
    else
      flash.now[:error] = @gym.errors.messages.first.join(" ")
      render 'edit'
    end
	end

	def destroy
    # @gym = Gym.find(params[:id])
    @gym = current_user.gyms.find(params[:id])
    @gym.destroy
    redirect_to gyms_path
	end

  private

  def gym_params
    params.require(:gym).permit(:name, :workout_url, :memberships)
  end
end
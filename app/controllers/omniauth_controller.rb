class OmniauthController < ApplicationController
  def create
    
    puts request.env['omniauth2.auth'].inspect

    # auth_hash = request.env['omniauth2.auth']
    
    # #session[:user_id]
    # # Means our user is signed in. Add the authorization to the user
    # #User.find(session[:user_id]).add_provider(auth_hash)
    # #auth = User.find_or_create(auth_hash)

    # if current_user
    #   current_user.update_attributes access_token: auth_hash["credentials"].secret,
    #                                  refresh_token: auth_hash["credentials"].token
    #   flash[:notice] = "Fitbit connected!"
    # end

    redirect_to root
  end
end
class OmniauthController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    
    #session[:user_id]
    # Means our user is signed in. Add the authorization to the user
    #User.find(session[:user_id]).add_provider(auth_hash)
    #auth = User.find_or_create(auth_hash)

    if current_user
      current_user.update_attributes access_token: auth_hash["credentials"].secret,
                                     refresh_token: auth_hash["credentials"].token
    end
  end
end
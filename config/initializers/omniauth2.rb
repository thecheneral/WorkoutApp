Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit_oauth2, '229RGM', '9ff210689c9d4f784b8d8b2ec88b99b2',
  	:redirect_uri => 'http://localhost:3000/auth/fitbit_oauth2/callback',
    :scope => 'profile activity sleep heartrate', :expires_in => '2592000',
    :prompt => 'login'
end

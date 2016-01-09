Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit_oauth2, ENV['FITBIT_CLIENT_ID'], ENV['FITBIT_CLIENT_SECRET'],
    :scope => 'profile activity sleep heartrate', :expires_in => '2592000',
    :prompt => 'login'
end

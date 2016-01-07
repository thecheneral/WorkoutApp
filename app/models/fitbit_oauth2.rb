class App < Sinatra::Base
  get '/' do
    redirect '/auth/fitbit_oauth2'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :fitbit_oauth2, '229RGM', '9ff210689c9d4f784b8d8b2ec88b99b2',
    :scope => 'profile activity sleep', :expires_in => '2592000',
    :prompt => 'login'
end

#provider :fitbit_oauth2, ENV['FITBIT_CLIENT_ID'], ENV['FITBIT_CLIENT_SECRET'],
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :sessions_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :homepage
  end

end

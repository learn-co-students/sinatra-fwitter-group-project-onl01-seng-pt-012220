require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_fwitter_secret"
  end

  get '/' do 
      erb :index   
  end

  get '/error' do 
    erb :error   
  end

  helpers do 

    def logged_in?(session)
      !!session[:user_id]
    end

    def current_user(session)
      User.find_by(id: session[:user_id])
    end
  end
end
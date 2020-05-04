

class UsersController < ApplicationController

  get '/' do 
      erb :home
  end

  get "/signup" do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end
    
  post "/signup" do
    if params[:username] != "" && params[:password] != ""  && params[:email]!= "" 
      user = User.new(:username => params[:username], :password => params[:password], :email => params[:email]) 	
        if user.save && user.username != ""
          session[:user_id] = user.id
          redirect "/tweets"
        else
            redirect "/signup"
        end
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end  
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/login'
    end
  end

  get '/users/:id' do 
    @user = User.find_by(:id => params[:id])
    @tweets = Tweet.all.select {|tweet| tweet.user_id == @user.id}
    erb :'users/show'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end

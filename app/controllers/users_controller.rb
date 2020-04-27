class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    end
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params)
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user.save
      session["user_id"] = @user.id
      redirect to "/tweets"
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session["user_id"] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
  erb :'/users/show'
  end

end

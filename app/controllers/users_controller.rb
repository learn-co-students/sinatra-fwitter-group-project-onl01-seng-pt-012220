class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to "/tweets"
    end
    erb :'users/new'
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
      @error = "an error occured please try again"
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

  # get '/logout' do
  #   if Helpers.is_logged_in?(session)
  #     erb :'users/logout'
  #   else
  #     redirect to '/'
  #   end
  # end
  #
  # post'/logout' do
  #   session.clear
  #   redirect to '/login'
  # end

  get '/users/:slug' do
      @user = User.find_by(params[:slug])
    erb :'/users/show'
  end

end

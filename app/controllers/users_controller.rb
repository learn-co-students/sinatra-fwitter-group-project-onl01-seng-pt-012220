class UsersController < ApplicationController

    #Users can create an account
    get '/users/new' do
        erb :'users/new'
    end

    #New accounts must have a username, email and password
    post '/users/new' do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/error"
        end

        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        binding.pry
        if user.save
          #login
          redirect to "/tweets"#redirect to all tweets?
        else
          redirect "/error"
        end
    end

    
    #Users can log in and log out
    get '/users/login' do
        erb :'users/login'
    end

    post '/users/login' do 
        user = User.find_by(:email => params[:email])
 
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets" #view all tweets?
        else
            redirect "/error"
        end
    end

    get '/users/logout' do
        erb :'users/logout'
    end

    post '/users/logout' do 
        session.destroy
        redirect "/" #view all tweets?
    end

    
    

end



class UsersController < ApplicationController

    #Users can create an account
    get '/signup' do
        if logged_in?(session)
             redirect to "/tweets"
        else
            erb :'/users/signup'
        end
    end

    #New accounts must have a username, email and password
    post '/signup' do 
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to "/signup"
        else
            user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            user.save
            session[:user_id] = user.id
            redirect to "/tweets"
        end
    end

    
    #Users can log in and log out
    get '/login' do
        if logged_in?(session)
            redirect to "/tweets"
        else
            erb :'users/login'
        end
    end

    post '/login' do 
        user = User.find_by(:username => params[:username])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            
            redirect "/tweets" 
        else
            redirect "/error"
        end
    end

    get '/logout' do
        if logged_in?(session)
            session.destroy
            redirect to "/login"
        else
            redirect to "/"
        end
    end

    get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end
end



class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do
        if logged_in?
        erb :'tweets/new'
        else
            redirect "/login"
        end
    end

    post '/tweets' do 
        if params[:content] != ""
            @tweet = Tweet.create(params)
            user = User.find_by(:id => session[:user_id])
            @tweet.user_id = user.id
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else 
            redirect "/tweets/new"
        end
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by(:id => params[:id])
            @user = User.find_by(:id => @tweet.user_id)
            erb :'tweets/show'
        else 
            redirect "/login"
        end
    end

    get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find_by(:id => params[:id])
            @user = User.find_by(:id => @tweet.user_id)
            erb :'tweets/edit'
        else
            redirect "/login" 
        end
    end

    patch '/tweets/:id/patch' do 
        if params["tweet"]["content"]  != ""
            @tweet = Tweet.find_by(:id=> params[:id])
            @tweet.update(params["tweet"])
            redirect "/tweets/#{@tweet.id}"
        else   
            redirect "/tweets/#{params[:id]}/edit"
        end
    end
    
    delete '/tweets/:id/delete' do 
        @tweet = Tweet.find_by(:id=> params[:id])
        if logged_in? && current_user == User.find_by(:id => @tweet.user_id)
            @tweet.delete 
            redirect to '/tweets'
        else
            redirect to '/tweets' 
        end
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


class TweetsController < ApplicationController

get '/tweets' do
    if logged_in?
        @tweets = Tweet.all
        erb :"tweets/index"
    else
        redirect "/login"
    end
end

get '/tweets/new' do
    if logged_in?
        erb :"tweets/new"
    else
        redirect "/login"
    end
end

post '/tweets' do
    @tweet = Tweet.new(:content => params["content"])
    @tweet.user_id = current_user.id
    
    if @tweet.save
        redirect "/tweets/#{@tweet.id}"
    else
        redirect "/tweets/new"
    end
end

get '/tweets/:id' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        @user = User.find(@tweet.user_id)
        erb :"tweets/show"
    else
        redirect "/login"
    end
end

delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if logged_in? && @tweet.user_id == current_user.id
        @tweet.delete
        redirect "/tweets"
    end
end

get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find(params[:id])
        @user = User.find(@tweet.user_id)
        erb :"tweets/edit"
    else
        redirect "/login"
    end
end

patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    if logged_in? && @tweet.user_id == current_user.id && params[:content] != ""
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets"
    else
        redirect "/tweets/#{@tweet.id}/edit"
    end
end

end

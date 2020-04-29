class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @user = current_user
      if !params["content"].empty?
        @tweet = Tweet.create(:content => params["content"], :user_id => @user.id)
        erb :'tweets/show_tweet'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end



  get '/tweets/:id/delete' do
    if logged_in? && Tweet.find_by_id(params[:id]).user == current_user
      Tweet.find_by_id(params[:id]).destroy
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect '/tweets/show_tweet'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if !params["content"].empty? && @tweet.is_a?(Tweet)
        @tweet.content = params[:content]
        @tweet.save
        redirect '/tweets/show_tweet'
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = Tweet.find_by_id(params[:id])
      tweet.destroy
    end
    redirect '/tweets'
  end
end

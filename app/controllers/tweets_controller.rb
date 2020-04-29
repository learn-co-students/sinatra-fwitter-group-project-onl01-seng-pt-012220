class TweetsController < ApplicationController
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if !params["content"].empty?
        @tweet = Tweet.create(:content => params["content"], :user_id => @user.id)
        erb :'tweets/show_tweet'
    else
        redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.is_a?(Tweet)
        redirect '/tweets/show_tweet'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    binding.pry
    @tweet = Tweet.find_by_id(params[:id])
    binding.pry
    if !params["content"].empty?
      @tweet.content = params[:content]
      @tweet.save
      redirect '/tweets/show_tweet'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    Tweet.destroy(params[:id])
  end
end

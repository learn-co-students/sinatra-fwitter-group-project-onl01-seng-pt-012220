class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
  if Helpers.is_logged_in?(session)
    @user = Helpers.current_user(session)
    erb :'/tweets/new'
  else
    redirect to '/login'
  end
end




end

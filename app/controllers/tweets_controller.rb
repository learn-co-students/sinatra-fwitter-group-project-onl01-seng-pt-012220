class TweetsController < ApplicationController

    #Users can create new tweets only if logged in
    get '/tweets/new' do 
        if logged_in?(session)
            erb :'/tweets/new'
        else
            erb :'/users/login'
        end
    end

    post '/tweets/new' do  
        #Blank tweets are not saved
        if !params[:content].empty?
            @tweet = Tweet.create(:content => params[:content])
            @tweet.user = current_user(session)
            @tweet.save
            redirect "/tweets"
        else
            redirect "/error"
        end
    end
    
    
    get "/tweets/:id/edit" do 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit'
    end
    
    patch '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        
        #Users can edit/delete only their tweets
        if @tweet.user == current_user(session)
            @tweet.content = params[:content]
            @tweet.save
        end
        redirect "/tweets"
    end
    
    #Users can view other users tweets
    get "/tweets" do 
        erb :'/tweets/tweets'
    end

end

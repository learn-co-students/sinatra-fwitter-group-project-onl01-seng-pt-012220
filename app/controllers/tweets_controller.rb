class TweetsController < ApplicationController

    #Users can create new tweets only if logged in
    get '/tweets/new' do 
        if logged_in?(session)
            erb :'/tweets/new'
        else
            redirect to "/login"
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
            redirect "/tweets/new"
        end
    end
    
    get "/tweets/:id" do 
        if logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect to "/login"
        end
        
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user == current_user(session)
            @tweet.delete
        end
        redirect "/tweets"
    end

    get "/tweets/:id/edit" do 
        if logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/edit'
        else 
            redirect "/login"
        end
    end
    
    patch '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
    
        if @tweet.user == current_user(session) && !params[:content].empty?
            @tweet.content = params[:content]
            @tweet.save
            redirect "/tweets"
        else
            redirect "/tweets/#{@tweet.id}/edit"
        end
        
    end
    
    #Users can view other users tweets
    get "/tweets" do 
        if logged_in?(session)
            erb :'/tweets/tweets'
        else
            redirect to "/login"
        end
    end

end

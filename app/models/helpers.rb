class Helpers < ActiveRecord::Base
    def is_logged_in?(session)
      !!session[:user_id]
    end
    
    def current_user(session)
      User.find(session[:user_id])
    end
end
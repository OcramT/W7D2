class ApplicationController < ActionController::Base
    helper_method :login_user!
    helper_method :current_user
    helper_method :logged_in?
    #write login, logout, logged_in? methods in here
    def login_user!(user)
        #what happens when we log in a user?
            #reset session token
        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        #check if user exists or not
        !!@current_user
    end

    def logout_user
        #set session token to nil
        session[:session_token] = nil
    end

    def current_user
        @current_user = User.find_by(session_token: session[:session_token])
    end

end

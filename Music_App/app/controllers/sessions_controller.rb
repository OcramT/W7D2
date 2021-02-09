class SessionsController < ApplicationController
    
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if user
            login_user!(@user)
            redirect_to user_url(@user)
        else
            render json: "sorry that didn't work, try again"
        end
    end

    def destroy
        logout_user
        redirect_to new_user_url
    end

end

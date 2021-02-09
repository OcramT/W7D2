class UsersController < ApplicationController

    def index
        User.all
        render :index
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login_user!(@user)
            redirect_to user_url(@user)
        else
            render json: "sorry that didn't work, try again"
        end
    end

    def show
        # @user = User.find_by_credentials(params[:users][:email], params[:users][:password])
        @user = User.find(params[:id])
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end

end

class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    
    def new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            flash[:notice] = 'Signup sucees'
            redirect_to articles_path
        else
            render "new"
        end
    end
    
    def user_params
        params.require(:user).permit(:email, :username, :password)
    end
    
    def set_user
        @user = User.new
    end
end
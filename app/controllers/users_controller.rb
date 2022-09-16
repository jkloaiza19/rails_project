class UsersController < ApplicationController
    before_action :verify_user_signed_in, except: [:new, :create]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def index
        @users = User.all.paginate(page: params[:page], per_page: 3)
    end
    
    def show
    end
    
    def new
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:notice] = 'Account updated successfully'
            redirect_to articles_path
        else
            render "new"
        end
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            create_session(@user[:id])
            flash[:notice] = 'Signup success'
            redirect_to articles_path
        else
            render "new"
        end
    end
    
    def destroy
        @user.destroy!
        destroy_session
        flash[:notice] = 'User deleted successfully'
        redirect_to root_path
    end
    
    def user_params
        params.permit(:email, :username, :password)
    end
    
    def set_user
        @user = User.find_by_id(params[:id])
    end
    
    def require_same_user
        if @user && @user.id != current_user.id
            flash[:alert] = "You can only update your own account"
            redirect_to users_path
        end
    end
end
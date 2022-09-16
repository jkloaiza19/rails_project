class SessionsController < ApplicationController
    def new
    end
    
    def create
        user = User.find_by(email: session_params[:email].downcase)
        
        raise ActiveRecord::RecordNotFound unless user
        
       if  user.authenticate(session_params[:password])
            create_session(user.id)
           flash[:notice] = 'Loged in successfully'
           
           redirect_to user
       else
           flash.now[:alert] = 'There was an error with credentials'
           render 'new'
       end
    end
    
    def destroy
        destroy_session
        flash[:notice] = 'Logged out'
        redirect_to root_path
    end
    
    def session_params
        params.require(:session).permit(:email, :password)
    end
end
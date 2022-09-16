class ApplicationController < ActionController::Base
    helper_method :current_user, :signed_in?
    
    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end
    
    def signed_in?
        !!current_user
    end
    
    def create_session(user_id)
        session[:user_id] = user_id
    end
    
    def destroy_session
        session[:user_id] = nil
    end
    
    def verify_user_signed_in
        return if signed_in?
        
        render json: { error: 'Unauthenticated' }, status: 404
    end
end

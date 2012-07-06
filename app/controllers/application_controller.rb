class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :update_last_seen

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
  
	def update_last_seen
    unless current_user == nil
		  current_user.last_seen = DateTime.now
     	current_user.save
	  end
	end
  
end

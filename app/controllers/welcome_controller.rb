class WelcomeController < ApplicationController
  def index
  	if current_user == nil 
  		@username = 'none'
  		@id = "log_in"
  	else
  		@username = current_user.username
  		@id = current_user.id
  	end
  end
end
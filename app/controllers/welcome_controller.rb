class WelcomeController < ApplicationController
  def index
  	# This creates an array of all contestant names for 'meet_the_cast' helper method.
      @contestants = []
      Contestant.all.each do |x|
        @contestants << x.name
      end


  	if current_user == nil 
  		@username = 'none'
  		@id = "log_in"
  	else
  		@username = current_user.username
  		@id = current_user.id
  	end
  end
end
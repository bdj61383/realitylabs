class ContestantsController < ApplicationController
	http_basic_authenticate_with :name => "admin", :password => "admin"

	def index 
		@contestants = Contestant.all
		@round = @contestants[0].round
	end

	def add_round
		@contestants = Contestant.all
		@round = @contestants[0].round
	end

	def update_round
		# This creates a back-up file to replace the one that was created at the end of the last 'update_round' action.  It's in here so that if leagues and users are created in-between rounds and then we need to 'reverse_round', we don't lose all that data.  
		Contestant.rake_db_copy
		
		@con = Contestant.all
		@next_round = @con[0].round + 1
		@conditions = ['survive', 'immunity', 'merger', 'final_three', 'winner']
		@array = []
		@con.each do |x|
			@conditions.each do |y|
				x.update_attribute("#{y}", params[:contestant]["#{x.id}_#{y}"])
				@array << params[:contestant]["#{x.id}_#{y}"]
			end
			
			
			x.update_attribute("round", @next_round)
		end

		User.add_column # This is what builds and runs the new migration file that will add a new column to the User model ActiveRecord.  It runs the migration, with no default value. 
		# User.reload
		@users = User.all
		@users.each do |user|
			user.update_attribute("score_round#{Contestant.first.round}", "#{user.score}")
		end

		

		# @params = params[:contestant].inspect
		Contestant.rake_db_copy
		redirect_to contestants_path
	end

	def reverse_round
		# This loads the info from the last round.
		@round = Contestant.first.round
		@last_round = @round - 1
		@dir = Dir.entries("db").select {|x| x =~ /^round#{@last_round}/}.to_s
		system("rake db:data:load_dir dir=#{@dir}")

		# This renames the dirname of the incorrect copy.  I'm leaving the filename of the migration alone, because it will need to be created anyway and doesn't seem to hurt anything being left in.
		@dir = Dir.entries("db").select {|x| x =~ /^round#{@round}/}.to_s
		File.rename "db/#{@dir}", "db/reverse_#{@dir}"
		redirect_to contestants_path
	end

	def new
    # default: render 'new' template
	end

	def create
	  @contestant = Contestant.new(params[:contestant])
	  @contestant.update_attributes(:round => 0, :survive => 1, :merger => 0, :immunity => 0, :final_three => 0, :winner => 0)
	  @contestant.save
	  flash[:notice] = "#{@contestant.name} was successfully created."
	  redirect_to contestants_path
	end

	def edit
	  @contestant = Contestant.find params[:id]
	end

	def update
	  @contestant = Contestant.find params[:id]
	  @contestant.update_attributes!(params[:contestant])
	  flash[:notice] = "#{@contestant.title} was successfully updated."
	  redirect_to contestant_path(@contestant)
	end

	def destroy
	  @contestant = Contestant.find(params[:id])
	  @contestant.destroy
	  flash[:notice] = "contestant '#{@contestant.title}' deleted."
	  redirect_to contestants_path
	end
end
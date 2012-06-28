class ContestantsController < ApplicationController

	def index 
		@contestants = Contestant.all
		@round = Contestant.find_by_id(1).round
	end

	def add_round
		@contestants = Contestant.all
	end

	def update_round
		# @contestants = Contestant.all
		@params = params[:contestant]['2_survive']
	end

	def new
    # default: render 'new' template
	end

	def create
	  @contestant = Contestant.new(params[:contestant])
	  @contestant.update_attributes(:round => 1, :survive => 1, :merger => 0, :immunity => 0, :final_three => 0, :winner => 0)
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
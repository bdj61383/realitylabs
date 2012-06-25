class LeaguesController < ApplicationController
	include ActiveModel::MassAssignmentSecurity
  def index
    @leagues = League.all
  end

  def new
    # default: render 'new' template
    # @league = League.new
  end

  def create
    @league = League.create!(params[:league])
    
    flash[:notice] = "#{@league.name} was successfully created."
    redirect_to leagues_path
  end

end
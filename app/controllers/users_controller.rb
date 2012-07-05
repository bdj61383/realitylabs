class UsersController < ApplicationController
  include ActiveModel::MassAssignmentSecurity
  module Exceptions
    class AuthenticationError < StandardError 
    end
    class InvalidLeagueNameOrCode < AuthenticationError 
    end
  end
    
  def show
    @user = current_user
    @id = params[:id]
    if @user == nil 
      redirect_to log_in_path
    elsif @user.id.to_i != params[:id].to_i
      # @error = 'You are signed in to the wrong account'
      redirect_to user_path(@user)
    end
  end
  
  def index
    @users = User.all
    @round = Contestant.find_by_id(1).round
  end

  def new
    # default: render 'new' template
    @league = League.new
    @user = User.new
  end

  def create
    @name = params[:league][:name]
    @code = params[:league][:confirmation_code]
    @league = League.find_by_name_and_confirmation_code(@name, @code)
    if @league == nil
      raise Exceptions::InvalidLeagueNameOrCode
    else
      @user = User.create!(params[:user])
      @league_id = @league.id
      @user.update_attribute('league_id', @league_id)
      flash[:notice] = "#{@user.username} was successfully created."
      redirect_to users_path
    end
  end

end
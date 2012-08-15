class UsersController < ApplicationController

  include ActiveModel::MassAssignmentSecurity
  module Exceptions
    class AuthenticationError < StandardError 
    end
    class InvalidLeagueNameOrCode < AuthenticationError 
    end
    class InvalidUsernameOrPassword < AuthenticationError 
    end
  end
  rescue_from Exceptions::InvalidLeagueNameOrCode, :with => :invalid_league
  rescue_from Exceptions::InvalidUsernameOrPassword, :with => :invalid_password

  def invalid_league
    redirect_to sign_up_path
    flash[:notice] = "Invalid league name or confirmation code"
  end

  def invalid_password
    redirect_to sign_up_path
    flash[:notice] = "Invalid username or password"
  end
    
  def show
    @user = current_user
    @id = params[:id]
    

    if @user == nil 
      redirect_to log_in_path
      flash[:notice] = "Please log in to continue."
    elsif @user.id.to_i != params[:id].to_i
      # @error = 'You are signed in to the wrong account'
      redirect_to user_path(@user)
    else 
      @league = @user.league
      @users = @league.users

      # This is to update the :contestant_pool attribute for the draft, but only if the draft hasn't already taken place.
      if current_user.lc == true && @league.draft_start == false
        @hash = {}
        @contestants = Contestant.all
        @contestants.each do |x|
          @hash.merge!(x.name => x.survive)
        end
        @hash = @hash.delete_if{|key, value| value == false}
        @league.update_attributes(:contestant_pool => @hash)
      end

      # This sets up the array for the 'drop user' form on the LC's page.  It's just an array of each user's name, excluding the LC.
      @usernames = []
      @drop_users = []
      @users.each do |user|
        @usernames << user.username
        unless user.lc == true
          @drop_users << user
        end
      end

      @round = Contestant.find_by_id(1).round
      @lc = @users.find_by_lc(true)
      # @draft_order = @league.draft_order
      @team = @user.team
      @ncontestants = @league.contestant_pool.length
      @nusers = @users.count
      @nrounds = (@ncontestants / @nusers).floor
      # @narray = @nusers * @nrounds
      
      # This handles an edge case where the LC has set teamsize to the maximum allowed and then another user joins the league.  In that instance, the teamsize would be greater than the maximum allowed or even possible, so we have to reset it manually to the maximum possible.
      if @league.teamsize > @nrounds
        @league.teamsize = @nrounds
        @league.save
      end
      

      
    end
  end
  
  def index
    @users = User.all
    @contestants = Contestant.all
    unless @contestants == nil
      @round = Contestant.find_by_id(1).round
    else
      @round = "No Contestants have been added"
    end
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
    elsif params[:user][:password] == nil || params[:user][:username] == nil
      raise Exceptions::InvalidUsernameOrPassword        
    else
      @user = User.new(params[:user])
      @league_id = @league.id
      @user.update_attribute('league_id', @league_id)
      if @user.save 
        session[:user_id] = @user.id
        flash[:notice] = "#{@user.username} was successfully created."
        redirect_to user_path(@user)
      else
        redirect_to sign_up_path
      end
    end
  end

  def delete_user
    @drop_user = User.find_by_id(params[:drop_user])
    @drop_user.delete
    render :js => "$('#drop_user_response').text('#{@drop_user.username} has been deleted.'); $('#drop_user option[value=#{@drop_user.id}]').remove()" 
  end

  def first_visit
    @user = current_user
    @user.update_attribute('first_visit', false)
    # @user.first_visit = false
    # if @user.save
    render :js => "$('#first_visit_response').text('This box will be gone next time you visit.')" 
    # end
  end

end
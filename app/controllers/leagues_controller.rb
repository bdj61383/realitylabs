class LeaguesController < ApplicationController
  # force_ssl :only => [:new, :create]
	include ActiveModel::MassAssignmentSecurity
  respond_to :html, :xml, :json

  include ActiveModel::MassAssignmentSecurity
  module Exceptions
    class AuthenticationError < StandardError 
    end
    class BlankLeagueNameOrCode < AuthenticationError 
    end
    class BlankUsernameOrPassword < AuthenticationError 
    end
  end
  rescue_from Exceptions::BlankLeagueNameOrCode, :with => :blank_league
  rescue_from Exceptions::BlankUsernameOrPassword, :with => :blank_password

  def blank_league
    redirect_to start_league_path
    flash[:notice] = "Blank league name or confirmation code"
  end

  def blank_password
    redirect_to start_league_path
    flash[:notice] = "Blank username or password"
  end

  def index
    @leagues = League.all
  end

  def edit
  end

  def update
    @league = League.find_by_id(params[:id])

    if params[:league_update_type] == 'league_update_score_sys'
      @league.scoring_system[:survive] = params[:survive]
      @league.scoring_system[:immunity] = params[:immunity]
      @league.scoring_system[:merger] = params[:merger]
      @league.scoring_system[:final_three] = params[:final_three]
      @league.scoring_system[:winner] = params[:winner]

      if @league.save
        render :js => "$('#score_sys_response').text('Update successful!')" 
      else
        render :js => "$('#score_sys_response').text('Oops, that didn't work.')"
      end
    end

    if params[:league_update_type] == 'league_update_teamsize'
      @league.teamsize = params[:teamsize]

      if @league.save
        render :js => "$('#teamsize_response').text('Update successful!')" 
      else
        render :js => "$('#teamsize_response').text('Oops, that didn't work.')"
      end
    end

    if params[:league_update_type] == 'send_new_invite'
      for i in 1..4
        @name = "email#{i}"
        unless params[:invite][@name.to_sym] == ""
          @email = params[:invite][@name.to_sym]
          Invite.invite_email(@email, @league.name, @league.confirmation_code).deliver
        end
      end
      unless params[:invite][:email1] == "" && params[:invite][:email2] == "" && params[:invite][:email3] == "" && params[:invite][:email4] == ""
        render :js => "$('#new_invite_response').text('Invitation sent!'); $('.new_invite').val('')" 
      else
        render :js => "$('#new_invite_response').text('Please enter at least one email address')" 
      end
    end

  end

  def add_to_team
    @member = params[:member].gsub("_", " ")
    @turn = params[:turn].to_i
    @turn = @turn + 1
    @user = User.find_by_username(params[:user])
    @league = @user.league
    @users = @league.users

    # This is what updates the member to the user's team.
    if @league.contestant_pool[@member] == true
      @team = @user.team << @member
      @user.update_attributes!(:team => @team)
      @user.save
    end

    # This is what changes the member's status to 'false' in :contestant_pool and update the round number.
    @league.contestant_pool[@member] = false
    next_round = @league.draft_round + 1
    @league.update_attribute("draft_round", next_round)
    respond_with @user
  end

  def show
    @user = current_user
    if @user == nil
      redirect_to log_in_path
    elsif @user.league_id.to_i != params[:id].to_i
      redirect_to league_path(@user.league)
    else
      @league = @user.league
    end
  end

  def new
    # default: render 'new' template
    @league = League.new
    @user = User.new
    @contestants = Contestant.all
  end

  def create

    
    # @user.update_attribute('league_id', @league_id)
    # @user.update_attribute('lc', 1)
    if params[:league][:name] == "" || params[:league][:confirmation_code] == ""
      raise Exceptions::BlankLeagueNameOrCode
    elsif params[:user][:username] == "" || params[:user][:password] == "" 
      raise Exceptions::BlankUsernameOrPassword        
    else
      @league = League.new(params[:league])
      @user = @league.users.build(params[:user])
      @league_id = @league.id
      @user.update_attributes(:league_id => @league_id, :lc => 1)

      #this is for creating the :contestant_pool default hash where 'name'=>'survive'
      @hash = {}
      @contestants = Contestant.all
      @contestants.each do |x|
        @hash.merge!(x.name => x.survive)
      end

      #this is for creating the :scoring_system default hash where 'survive'=>'1', etc.
      @score = {:survive => 1, :immunity => 1, :merger => 1, :final_three => 1, :winner => 1}
      @league.update_attributes(:contestant_pool => @hash, :scoring_system => @score)

      if @league.save
        # Here is where we send out email invites to the people listed by the LC.  I've put this code here so that invites are only sent if the league creation is successful.
        for i in 1..8
          @name = "email#{i}"
          unless params[:invite][@name.to_sym] == ""
            @email = params[:invite][@name.to_sym]
            Invite.invite_email(@email, @league.name, @league.confirmation_code).deliver
          end
        end
        
        # Here is where we log the user in by creating a new Session instance.
        session[:user_id] = @user.id
        redirect_to user_path(@user), :notice => "#{@league.name} successfully created!"
      else
        render :action => 'new'
      end
      flash[:notice] = "#{@league.name} was successfully created." # Had to comment this out to get my tests working correctly.  Worrisome.
      # redirect_to leagues_path
    end
  end

  def check_league_name
    @new_name = params[:new_name]
    if League.find_by_name(@new_name) == nil
      render :js => "$('#check_league_name_response').text('available').addClass('username_available').removeClass('username_unavailable')" 
    else
      render :js => "$('#check_league_name_response').text('already taken').addClass('username_unavailable').removeClass('username_available')" 
    end
  end

# This is the LC Control Panel
  def draft_preview
    @league = League.find_by_id(params[:id])

    # # This is to update the :contestant_pool attribute for the draft
    # @hash = {}
    # @contestants = Contestant.all
    # @contestants.each do |x|
    #   @hash.merge!(x.name => x.survive)
    # end
    # @hash = @hash.delete_if{|key, value| value == false}
    # @league.update_attributes(:contestant_pool => @hash)
    
    @users = @league.users
    @user = current_user
    @ncontestants = @league.contestant_pool.length
    @nusers = @users.count
    @nrounds = @league.teamsize
    @narray = @nusers * @nrounds

    # This is how we will set up the array that basically is the draft pick-list and assign it to the league's :draft_order attribute.  
    @pick_list = []
    for i in 1..@nrounds
      if i.odd?
        @array = @users.shuffle
        n = @array.length
        for i in 0...n
          @pick_list << @array[i]
        end
      else
        index = @pick_list.length - 1
        for n in 0...@nusers
          @pick_list << @pick_list[index-n]
        end
      end
    end
    @draft_order = []
    @pick_list.each do |x|
      @draft_order << x.username
    end
    @league.update_attributes(:draft_order => @draft_order)

    # This is just used to redirect people if they try to access this page and they aren't the lc for this league.
    if @user == nil
      redirect_to log_in_path
    else
      unless @user.lc == true && @user.league_id == params[:id].to_i
      # unless @user.league_id == @id
        redirect_to user_path(@user)
      end
    end
  end

  def start_draft
    # This is just used to redirect people if they try to access this action and they aren't the lc for this league.
    @user = current_user
    if @user == nil
      redirect_to log_in_path
    else
      unless @user.lc == true && @user.league_id == params[:id].to_i
      # unless @user.league_id == @id
        redirect_to user_path(@user)
      end
    end
    
    League.find_by_id(params[:id]).update_attributes(:draft_active => true, :draft_start => true)
    redirect_to draft_path
    # sleep(2)
    # redirect_to log_in_path
    
  end

  # def begin_draft
  #   @league = League.find_by_id(params[:id])
  #   @league.draft
  #   respond_with @league
  # end


  def draft
    # This begins the draft
    # if League.find_by_id(params[:id]).draft_start == true
    #   sleep(2)
    #   League.find_by_id(params[:id]).draft
    # end

    # This redirects users who are not logged in
    unless current_user == nil
      @user = current_user
      @league = @user.league

      # This sets the league's 'draft_active' attribute to 'true' so that the page can be accessed by other users.
      # if @user.lc == true 
      #   @league.update_attribute("draft_active", "true")
      # end

      # This redirects users who try to access another league's draft
      if @user.league_id != params[:id].to_i
        redirect_to user_path(@user)
        flash[:notice] = "The draft can only be started by the League Commissioner.  The LC can start the draft by accessing the LC Control Box in the toolbar to the bottom right."
        return

      # This redirects users who try to access the draft page when the draft is unavailable. 
      elsif @league.draft_active == false
        redirect_to user_path(@user) 
        flash[:notice] = "#{@user.username}, your draft hasn't started yet!"
        return
      end

      

      @users = @league.users
      @draft_order = @league.draft_order
      @team = @user.team
      @ncontestants = @league.contestant_pool.length
      @nusers = @users.count
      @nrounds = @league.teamsize
      @narray = @nusers * @nrounds
      @turn = @league.draft_round
      @up = @draft_order[@turn]
      @pool = []
      @league.contestant_pool.each_key do |key|
        @pool << key
      end
      @pool = @pool.sort!  #This is a quick-fix sort by first name until I write the regex to sort by last name



      # This is what ends the draft when everyone has picked
      unless (@turn + 1) >= @draft_order.length

        # This will run the 'draft' method if the current user is the LC, meaning it will only get run once per turn and not by every user per turn.  The redirect is in there to handle the edge case where the first person who is 'up' is not online, in which case the auto_draft method runs too quickly for the LC's browser to catch the Faye signal and refresh.
        # if @user.lc == true
        #   @league.auto_draft(@draft_order[@turn])
        #   if User.find_by_username(@draft_order[@turn]).online == false
        #     redirect_to draft_page_path
        #   end
        # end

        # This gives us an array of users who are logged-in.
        @online = []
        @offline = []
        @league.users.each do |user|
          if user.online == true
            @online << user.username
          else
            @offline << user.username
          end

        end

      else
        redirect_to user_path(@user)
        flash[:notice] = "Your draft has ended."
      end

    else
      redirect_to log_in_path
    end
  end

  def end_draft
    @user = current_user
    @league = @user.league
    @league.update_attribute('draft_active', 'false')
    render :nothing => true
  end

end
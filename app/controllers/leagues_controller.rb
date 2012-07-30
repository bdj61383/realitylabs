class LeaguesController < ApplicationController
	include ActiveModel::MassAssignmentSecurity
  respond_to :html, :xml, :json

  def index
    @leagues = League.all
  end

  def edit
  end

  def update
  end

  def add_to_team
    @member = params[:member].gsub("_", " ")
    @turn = params[:turn].to_i
    @turn = @turn + 1
    @user = User.find_by_username(params[:user])
    @league = @user.league
    @users = @league.users

    # This is what updates the member to the user's team.
    @team = @user.team << @member
    @user.update_attributes!(:team => @team)
    @user.save

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
    @league = League.new(params[:league])
    @user = @league.users.build(params[:user])
    @league_id = @league.id
    # @user.update_attribute('league_id', @league_id)
    # @user.update_attribute('lc', 1)
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
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
    flash[:notice] = "#{@league.name} was successfully created." # Had to comment this out to get my tests working correctly.  Worrisome.
    # redirect_to leagues_path
  end

  def draft
    @league = League.find_by_id(params[:id])

    # This is to update the :contestant_pool attribute for the draft
    @hash = {}
    @contestants = Contestant.all
    @contestants.each do |x|
      @hash.merge!(x.name => x.survive)
    end
    @hash = @hash.delete_if{|key, value| value == false}
    @league.update_attributes(:contestant_pool => @hash)
    
    @users = @league.users
    @user = current_user
    @ncontestants = @league.contestant_pool.length
    @nusers = @users.count
    @nrounds = (@ncontestants / @nusers).floor
    @narray = @nusers * @nrounds

    # This is how we will set up the array that basically is the draft pick-list and assign it to the league's :draft_pick attribute.  
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

  def set_draft
    
    League.find_by_id(params[:id]).update_attributes(:draft_active => true, :draft_start => true)
    redirect_to draft_page_path
    # sleep(2)
    # redirect_to log_in_path
    
  end

  def begin_draft
    @league = League.find_by_id(params[:id])
    @league.draft
    respond_with @league
  end


  def start_draft
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
      @nrounds = (@ncontestants / @nusers).floor
      @narray = @nusers * @nrounds
      @turn = @league.draft_round
      @up = @draft_order[@turn]

      # This is what ends the draft when everyone has picked
      unless (@turn + 1) >= @draft_order.length

        # This will run the 'draft' method if the current user is the LC, meaning it will only get run once per turn and not by every user per turn.  The redirect is in there to handle the edge case where the first person who is 'up' is not online, in which case the auto_draft method runs too quickly for the LC's browser to catch the Faye signal and refresh.
        if @user.lc == true
          @league.auto_draft(@draft_order[@turn])
          if User.find_by_username(@draft_order[@turn]).online == false
            redirect_to draft_page_path
          end
        end

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
      end

    else
      redirect_to log_in_path
    end
  end

end
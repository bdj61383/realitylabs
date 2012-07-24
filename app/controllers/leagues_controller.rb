class LeaguesController < ApplicationController
	include ActiveModel::MassAssignmentSecurity
  respond_to :html, :xml, :json

  def index
    @leagues = League.all
  end

  def edit
  end

  def update
    # @movie = Movie.find params[:id]
    # @movie.update_attributes!(params[:movie])
    # flash[:notice] = "#{@movie.title} was successfully updated."
    # redirect_to movie_path(@movie)
  end

  def add_to_team
    @member = params[:member].gsub("_", " ")
    @turn = params[:turn].to_i
    @turn = @turn + 1
    @user = current_user
    @league = @user.league
    @users = @league.users

    # This is what updates the member to the user's team.
    @team = @user.team << @member
    @user.update_attributes!(:team => @team)
    @user.save

    # This is what changes the member's status to 'false' in :contestant_pool
    @league.contestant_pool[@member] = false
    @league.save
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

  def start_draft
    # This redirects users who are not logged in
    unless current_user == nil
      @user = current_user
      @league = @user.league

      # This sets the league's 'draft_active' attribute to 'true' so that the page can be accessed by other users.
      if @user.lc == true 
        @league.update_attribute("draft_active", "true")
      end

      # This redirects users who try to access another league's draft
      if @user.league_id != params[:id].to_i
        redirect_to user_path(@user)
        flash[:notice] = "The draft can only be started by the League Commissioner.  The LC can start the draft by accessing the LC Control Box in the toolbar to the bottom right."

      # This redirects users who try to access the draft page when the draft is unavailable. 
      elsif @league.draft_active == false
        redirect_to user_path(@user)
        flash[:notice] = "#{@user.username}, your draft hasn't started yet!"
        
      end

      

      @users = @league.users
      @draft_order = @league.draft_order
      @team = @user.team
      @ncontestants = @league.contestant_pool.length
      @nusers = @users.count
      @nrounds = (@ncontestants / @nusers).floor
      @narray = @nusers * @nrounds

      @pool = @league.contestant_pool
      @turn = 1
      @pool.each_value do |value|
        if value == false
          @turn += 1
        end
      end
    else
      redirect_to log_in_path
    end
  end

end
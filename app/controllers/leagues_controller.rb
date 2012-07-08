class LeaguesController < ApplicationController
	include ActiveModel::MassAssignmentSecurity
  def index
    @leagues = League.all
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

    # This is how we will set up the array that basically is the draft pick-list.
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



    if @user == nil
      redirect_to log_in_path
    else
      unless @user.lc == true && @user.league_id == params[:id].to_i
      # unless @user.league_id == @id
        redirect_to user_path(@user)
      end
    end
  end

end
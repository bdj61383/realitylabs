class LeaguesController < ApplicationController
	include ActiveModel::MassAssignmentSecurity
  def index
    @leagues = League.all
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
    @user.update_attribute('league_id', @league_id)
    @user.update_attribute('lc', 1)

    #this is for creating the :contestant_pool default hash where 'name'=>'survive'
    @hash = {}
    @contestants = Contestant.all
    @contestants.each do |x|
      @hash.merge!(x.name => x.survive)
    end
    @league.update_attribute('contestant_pool', @hash)

    if @league.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
    flash[:notice] = "#{@league.name} was successfully created." # Had to comment this out to get my tests working correctly.  Worrisome.
    # redirect_to leagues_path
  end

end
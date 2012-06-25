class UsersController < ApplicationController
  include ActiveModel::MassAssignmentSecurity
  def index
    @users = User.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @user = User.create!(params[:user])
    flash[:notice] = "#{@user.username} was successfully created."
    redirect_to users_path
  end
end
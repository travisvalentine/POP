class ProfilesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index]

  def new
    @profile = Profile.new(params[:profile])
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      redirect_to @user.profile, :alert => 'User successfully added.'
    else
      render :new
    end
  end

  def index
    @profile = current_user.profile
  end

  def show
    @profile = Profile.find(params[:id])
    @user = User.find(@profile.user_id)
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to profile_path, :alert => 'Updated user information successfully.'
    else
      render :edit
    end
  end
end

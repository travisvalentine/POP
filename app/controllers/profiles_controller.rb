class ProfilesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  
  def new
    @profile = Profile.new(params[:profile])
  end

  def create
    @profile = Profile.new(params[:profile])
    if @profile.save
      redirect_to @user.profile, :notice => 'User successfully added.'
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
    @profile_problems = Problem.find_all_by_user_id(@profile.user_id)
  end

  def edit
    @profile = user.profile
    render :layout => "join_form"
  end

  def update
    @profile = user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to profile_path, :notice => 'Updated user information successfully.'
    else
      render :edit
    end
  end
end

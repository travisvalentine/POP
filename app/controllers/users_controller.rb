class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]

  def new
    @user = User.new
    @user.profile = Profile.new
    if logged_in?
      redirect_to problems_path
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save!
      session[:user_id] = @user.id
      Resque.enqueue(Emailer, @user.id)
      redirect_to problems_path, :alert => 'Welcome! See what other people are saying below.'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to settings_path, :alert => 'Updated user information successfully.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to root_path
    else
      redirect_to settings_path
    end
  end

end

class SettingsController < ApplicationController
  layout "application"

  def show
    @user = current_user
    @profile = @user.profile
  end

  def create
  end

  def index
    @user = User.find(params[:id])
    @profile = Profile.find(@user.id)
  end

  def show_settings
    @profile = user.profile
    @profile.save!
    if @profile.save
      redirect_to settings_path
    end
  end

end

class SettingsController < ApplicationController
  before_filter :authenticate

  def show
    @user = current_user
    @profile = @user.profile
  end

end

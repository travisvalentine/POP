class SignupController < ApplicationController
  before_filter :authenticate

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to problems_path
    else
      render :edit, :alert => "Something went wrong. Try again."
    end
  end

end
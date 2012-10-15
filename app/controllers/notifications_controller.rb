class NotificationsController < ApplicationController
  before_filter :authenticate

  def update
    @notification = current_user.notifications.find(params[:id])
    if @notification.update_attribute(:read, params[:read])
      redirect_to(:back)
    else
      redirect_to(:back, :notice => "Something went wrong.")
    end
  end
end
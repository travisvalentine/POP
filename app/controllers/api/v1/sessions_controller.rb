class Api::V1::SessionsController < ApplicationController
  before_filter :set_return_session

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to session[:return_to], :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password. Try again!"
      render :action => 'new'
    end
  end

end

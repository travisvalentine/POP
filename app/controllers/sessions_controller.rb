class SessionsController < ApplicationController
  before_filter :set_return_session, :only => [:create]

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to problems_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password. Try again!"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end

end

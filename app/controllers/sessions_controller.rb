class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to problems_path, :alert => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password. Try again!"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :alert => "You successfully logged out"
  end

end

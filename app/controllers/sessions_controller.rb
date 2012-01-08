class SessionsController < ApplicationController
  layout "application"
  def create
    if user = User.authenticate(params[:email].downcase, params[:password])
      session[:user_id] = user.id
      redirect_to new_problem_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password. Try again!"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    #cookies.delete(:auth_token)
    redirect_to root_path, :notice => "You successfully logged out"
  end
end

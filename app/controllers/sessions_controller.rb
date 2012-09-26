class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if params[:email] and params[:password]
      user = User.authenticate(params[:email], params[:password])
    else
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
             User.create_with_omniauth(auth)
    end
    if user
      if user.email.blank? and user.profile.blank?
        Profile.create_with_omniauth(user.id, auth)
      end
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

private

end

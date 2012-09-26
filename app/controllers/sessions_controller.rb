class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if params[:email] and params[:password]
      puts "Auth via Email"
      user = User.authenticate(params[:email], params[:password])
    else
      puts "Auth via Twitter"
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
             User.create_with_omniauth(auth)
    end
    if user
      if user.email.blank? and user.profile.blank?
        puts "Creating profile from #{user} - #{user.profile}"
        Profile.create_with_omniauth(user.id, auth)
      end
      session[:user_id] = user.id
      puts "Session set to User ID"
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

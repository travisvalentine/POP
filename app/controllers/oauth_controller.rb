class OauthController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

    if user.nil?
      user = User.create_with_omniauth(auth)
      Profile.create_with_omniauth(user.id, auth)
      session[:user_id] = user_id
      redirect_to welcome_path
      return
    elsif user.present? and user.profile.present?
      user.update_from_omniauth(auth)
      session[:user_id] = user.id
      redirect_to problems_path, :notice => "Welcome back!"
    end
  end

private

  def login_from_oauth(user_id)
    session[:user_id] = user_id
    redirect_to welcome_path
  end

end
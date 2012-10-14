class OauthController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if auth.nil? || auth.blank?
      redirect_to root_path, :notice => "We can't access Twitter at this time. Please try again."
    end

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

    if user.nil?
      user = User.create_with_omniauth(auth)
      Profile.create_with_omniauth(user.id, auth)
      login_from_oauth(user.id)
      return
    elsif user.present? && user.profile.present?
      user.update_from_omniauth(auth)
      session[:user_id] = user.id
      redirect_to problems_path, :notice => "Welcome back!"
    elsif user.present? && user.profile.nil?
      redirect_to root_path, :notice => "Something went wrong. We're working on a fix."
    end
  end

private

  def login_from_oauth(user_id)
    session[:user_id] = user_id
    redirect_to welcome_path
  end

end
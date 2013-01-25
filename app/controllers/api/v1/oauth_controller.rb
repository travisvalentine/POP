class Api::V1::OauthController < ApiController

  def create
    auth = request.env["omniauth.auth"]
    if auth.nil? || auth.blank?
      redirect_to api_v1_login_path, :notice => "We can't access Twitter at this time. Please try again."
    end

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

    if user.present? && user.profile.present?
      user.update_from_omniauth(auth)
      session[:user_id] = user.id
      redirect_to new_api_v1_politician_problem_path, :notice => "Welcome back!"
    else
      redirect_to api_v1_goodbye_path, :notice => "Something went wrong so we are redirecting you to the main app."
    end
  end

end
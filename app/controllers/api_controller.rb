class ApiController < ActionController::Base
  # before_filter :verify_api_token

  def current_user
    @current_user ||= lookup_user
  end
  helper_method :current_user

  def lookup_user
    User.find_by_api_token(params[:user][:api_token])
  end

end
class ApplicationController < ActionController::Base
  protect_from_forgery

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate
    logged_in? ? true : access_denied
  end

  def access_denied
    redirect_to login_path, :alert => "Please log in to continue" and return false
  end

  def create_user_session
    session[:user_id] = @user.id
  end

  def reset_session
    session[:user_id] = nil
  end
  helper_method :reset_session

  def set_return_session
    session[:return_to] = request.referer
  end

  def logged_in?
    current_user.is_a? User
  end
  helper_method :logged_in?

  def homepage?
    request.fullpath == problems_path
  end
  helper_method :homepage?

  def signing_up?
    request.fullpath == signup_path
  end
  helper_method :signing_up?

  def completing_profile?
    request.fullpath == welcome_path
  end
  helper_method :completing_profile?

end
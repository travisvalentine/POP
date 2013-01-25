class ApiController < ActionController::Base
  before_filter :set_return_session

  # specify layout, otherwise there would be no styles
  layout 'widget'

  # reuse helpers from application_controller
  # so there isn't a need to create a new layout
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

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

  def set_return_session
    session[:return_to] = request.referer
  end

  def authenticate
    logged_in? ? true : access_denied
  end

  def access_denied
    redirect_to api_v1_login_path, :alert => "Please log in to continue" and return false
  end

end
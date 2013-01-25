class Api::V1::SessionsController < ApiController
  before_filter :set_return_session

  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to session[:return_to], :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password. Try again!"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to api_v1_goodbye_path, :notice => "We are redirecting you to the main app."
  end
end

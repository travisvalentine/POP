class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to new_password_reset_path, :notice => "Check your email for password reset instructions."
    else
      redirect_to new_password_reset_path, :notice => "Sorry, we couldn't find that email. Please try again."
    end
    
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    session[:user_id] = @user.id
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Your password reset link has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to profile_path(@user), :notice => "Great news: Your password has been reset."
    else
      render :edit
    end
  end
end
class UserMailer < ActionMailer::Base

  default :from => "oursolutionis <oursolutionis@gmail.com>",
          :return_path => "oursolutionis@gmail.com"

  def password_reset(user)
    @user = user
    mail(
      :to => "#{@user.email}",
      :subject => "Check yourself and reset yourself"
    )
  end

  def registration_confirmation(user)
    @user = user
    mail(
      :to => "#{@user.email}",
      :subject => "Thanks for Signing Up!"
    )
  end
end

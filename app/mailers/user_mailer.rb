class UserMailer < ActionMailer::Base

  default :from => "Test <hungryopensource@gmail.com>",
          :return_path => "hungryopensource@gmail.com"

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

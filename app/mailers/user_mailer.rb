class UserMailer < ActionMailer::Base

  default :from => "Test <hungryopensource@gmail.com>",
          :return_path => "hungryopensource@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail(:to => "#{user.email}", :subject => "Check yourself and reset yourself")
  end
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.email}", :subject => "Welcome!")
  end
end

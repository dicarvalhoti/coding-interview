class UserMailer < ApplicationMailer

  default from: "notifications@appmail.com"

  def welcome_to_app(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to App!!!')
  end
end

class OdinMailer < ApplicationMailer
  default from: 'no-reply@odinbook.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'Welcome to Odinbook!')
  end
end

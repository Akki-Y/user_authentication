class UserMailer < ApplicationMailer
  def signup_confirmation(user)
    @user = user
    @verification_link = verify_users_url(token: @user.verification_token)
    mail(to: @user.email, subject: 'Account created successfully')
  end
end

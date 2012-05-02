class SignupMailer < ActionMailer::Base
  default from: "info@thirtyflights.com"
  
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Yela confirmation"
  end
end

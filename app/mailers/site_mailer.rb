class SiteMailer < ActionMailer::Base
  default from: "info@thirtyflights.com"
  
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "TiniHost confirmation"
  end
  
  def mail_friend(email, current_user, user, note)
    @email = email
    @recommender = current_user
    @user = user
    @note = note
    mail to: email, suject: "Lokolit recommendation from" "#{@recommender.firstname}"
  end
end
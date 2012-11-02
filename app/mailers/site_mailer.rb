class SiteMailer < ActionMailer::Base
  default from: "team@tiniHost.com"
  
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "TiniHost signup confirmation"
  end
  
  def mail_friend(email, current_user, user, note)
    @email = email
    @recommender = current_user
    @user = user
    @note = note
    mail to: email, subject: "Tinihost recommendation from #{@recommender.firstname.capitalize}"
  end
  
  def mail_new_request(traveler, host, appointment)
    @traveler = traveler
    @host = host
    @appointment = appointment
    mail to:host.email, subject: "TiniHost - You have a new meetup request from #{traveler.firstname.capitalize}"
  end
  
  def mail_available(traveler, host, appointment)
    @traveler = traveler
    @host = host
    @appointment = appointment
    mail to:traveler.email, subject: "TiniHost - #{host.firstname.capitalize} responded available to your meetup request"
  end
  
  def mail_booked(traveler, host, appointment)
     @traveler = traveler
     @host = host
     @appointment = appointment
     mail to:host.email, subject: "TiniHost - #{traveler.firstname.capitalize} has booked a meetup with you!"
   end
end
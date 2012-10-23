class MailerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(user_id)
    @user = User.find_by_id(user_id)
    SiteMailer.signup_confirmation(@user).deliver
  end
end
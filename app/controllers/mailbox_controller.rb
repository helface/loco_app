class MailboxController < ApplicationController
before_filter :signed_in_user

  def show
    store_nav_history
    if params[:folder] == 'inbox'
      @messages = current_user.received_msgs.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    elsif params[:folder] == 'sent'
      @messages = current_user.sent_msgs.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    end
  end
end

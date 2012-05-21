class MailboxController < ApplicationController
before_filter :signed_in_user

  def index
  end

  def show
    if params[:folder] == 'inbox'
      @messages = current_user.received_msgs.paginate(page: params[:page], per_page: 10)
    elsif params[:folder] == 'sent'
      @messages = current_user.sent_msgs.paginate(page: params[:page], per_page: 10)
    end
  end
end

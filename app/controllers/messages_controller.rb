class MessagesController < ApplicationController
before_filter :signed_in_user
before_filter :unique_to_from, only: [:new, :create]

  def new
  end

  def create 
  
    @message = current_user.sent_msgs.build(params[:message])
    @msgthread = Msgthread.find(params[:message][:thread_id])
    if @message.save
      @msgthread.update_attributes(:subject => @message.subject)
      flash[:success] = "your message has been sent"
      redirect_back_or( User.find(params[:message][:recipient_id]))
    else
      flash[:error] = "Sorry, we were unable to send your message"
      redirect_to current_user
    end
  end

  def index
  end

  def show
  end
end

private

def unique_to_from
  if User.find(params[:message][:recipient_id]) == current_user
    redirect_to root_path
  end
end


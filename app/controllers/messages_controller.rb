class MessagesController < ApplicationController
before_filter :signed_in_user

  def new
    @user = User.find(params[:user_id])
    @message = Message.new
  end

  def create  
    @recipient = User.find_by_id(params[:user_id])
    @message = current_user.sent_msgs.build(params[:message])
    @message.recipient_id = @recipient.id
    @msgthread = Msgthread.build_message_thread(@message)
    @message.thread_id = @msgthread.id
    if @message.save
      flash[:success] = "your message has been sent"
      redirect_to user_msgthread_path(current_user, @msgthread)
    else
      flash[:error] = "Sorry, we were unable to send your message"
      redirect_to current_user
    end
  end

  def show
  end
  
  def destroy
    @message = Message.find_by_id(params[:id])
    @thread = Msgthread.find_by_id(@message.thread_id)
    if current_user.id == @message.recipient_id && !@message.removed_by_recipient
      @message.toggle!(:removed_by_recipient)
    elsif current_user.id == @message.sender_id && !@message.removed_by_sender
      @message.toggle!(:removed_by_sender)
    end
    
    #delete thread if all messages in the thread have been deleted
    if @message.removed_by_recipient && @message.removed_by_sender
      @message.destroy
      if @thread.messages.empty?
        @thread.destroy
      end
    end 
    redirect_to mailbox_path(current_user, folder: "inbox")
    
  end
  
end

private

#def unique_to_from
#  if User.find(params[:message][:recipient_id]) == current_user
#    redirect_to root_path
#  end
#end


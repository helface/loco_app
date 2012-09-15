class MessagesController < ApplicationController
before_filter :signed_in_user
before_filter :is_owner, only: [:destroy, :show]

  def new
    @user = User.find(params[:user_id])
    @message = Message.new
  end

  def create  
    sender = current_user
    @recipient = User.find_by_id(params[:user_id])
    @message = sender.sent.build(params[:message])
    @message.recipient_id = @recipient.id
    @message.owner_id = sender.id   
    @message_copy = @message.copy_message(@recipient.id) #making a copy of email for the recipient   
    @thread = Msgthread.build_message_thread(@message)
    @message.thread_id = @message_copy.thread_id = @thread.id
    if @message.save && @message_copy.save
      flash[:success] = "your message has been sent"
      redirect_to user_message_path(@recipient, @message)
    else
      flash[:error] = "Sorry, we were unable to send your message"
      redirect_to current_user
    end
  end

  def show    
    message = Message.find_by_id(params[:id])
    message.toggle!(:read) unless message.read
    @thread = Msgthread.find_by_id(message.thread_id)
    @recipient = User.find_by_id(params[:user_id])    
    @messages = @thread.messages.where(:owner_id => current_user.id).order('created_at DESC')
  end
  
  def destroy
    @message = Message.find_by_id(params[:id])
    @thread = Msgthread.find_by_id(@message.thread_id)
    @message.destroy
    if @thread.messages.empty?
       @thread.destroy
    end
    redirect_to mailbox_path(current_user, folder: params[:folder])  
    
  end
  
end

private

   def is_owner
     message = Message.find_by_id(params[:id])
     current_user.id == message.owner_id
   end

#def unique_to_from
#  if User.find(params[:message][:recipient_id]) == current_user
#    redirect_to root_path
#  end
#end


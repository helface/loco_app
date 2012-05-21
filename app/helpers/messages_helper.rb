module MessagesHelper
  
def build_message_thread
  @message = current_user.sent_msgs.build(params[:message])
  
  #create a thread container if message starts a new thread
  if @message.thread_id.nil?
    @msgthread = Msgthread.create!(participant1_id: current_user, 
                                    participant2_id: @message.recipient_id,
                                    subject: @message.subject)
    if @msgthread.nil?
      flash[:error] = "message thread failed"
      redirect_to root_path
    end  
    @message.thread_id = @msgthread.id
  else
    @msgthread = Msgthread.find(@message.thread_id)
  end
  
  if @message.save
    flash[:success] = "your message has been sent"
    redirect_to user_msgthread_path(current_user, @msgthread)
  else
    flash[:error] = "Sorry, we were unable to send your message"
    redirect_to current_user
  end
end

end

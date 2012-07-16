class Msgthread < ActiveRecord::Base
attr_accessible :participant1_id, :participant2_id, :subject
has_many :messages, foreign_key: "thread_id"
validates_presence_of :participant1_id, :participant2_id

def find_recipient_id(current_user)
  if current_user.id == self.participant1_id
    return self.participant2_id
  else
    return self.participant1_id
  end
end

def self.build_message_thread(message)
 # @message = current_user.sent_msgs.build(params[:message])
  #@message.recipient_id = params[:user_id]
  
  #create a thread container if message starts a new thread
  
  if message.thread_id.nil?		
    @msgthread = Msgthread.create!(participant1_id: message.sender_id, 
                                    participant2_id: message.recipient_id,
                                    subject: message.subject)
    if @msgthread.nil?
      flash[:error] = "failed to create message thread"
      redirect_to root_path
      return
    end  
  else
    @msgthread = Msgthread.find_by_id(message.thread_id)
  end
  return @msgthread
end

end

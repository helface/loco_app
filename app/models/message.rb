class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"
  belongs_to :msgthread 
  belongs_to :recipient, :class_name => "User"
  attr_accessible :subject, :body, :recipient_id, :thread_id
  scope :unread, :conditions=>["read = ?", false]
  validates_presence_of :subject, :body, :sender_id, :recipient_id, :thread_id
  validates :subject, presence:true, length:{maximum: 100}
  
  #state_machine :state, :initial => :unsent
  
  def copy_message(owner)
    message_copy = self.dup
    message_copy.owner_id = owner
    return message_copy
  end
  
end

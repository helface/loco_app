class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"
  belongs_to :msgthread 
  #has_one :recipient, :class_name => "User", :dependent => :destroy
  belongs_to :recipient, :class_name => "User"
  attr_accessible :subject, :body, :recipient_id, :thread_id
  
  validates_presence_of :subject, :body, :sender_id, :recipient_id, :thread_id
  validates :subject, presence:true, length:{maximum: 100}
  
  #state_machine :state, :initial => :unsent
end

# Mailbox 
# Each user has an inbox and a 'sent messages' folder
# Functionalities include: delete, index, 

class Mailbox < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id
end

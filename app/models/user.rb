# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  firstname       :string(255)
#  lastname        :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation, :profile_pic_id, :self_intro
  has_secure_password
  has_many :images, :dependent => :destroy
  
  #has many reviews
  has_many :reviews, foreign_key: "reviewer_id", dependent: :destroy
  
  #has many reviewed users
  has_many :reviewees, through: :reviews, source: :reviewee
  
  #has received many reviews
  has_many :inverse_reviews, class_name: "Review", foreign_key: "reviewee_id"
  
  #has many reviewee
  has_many :inverse_reviewees, through: :inverse_reviews, source: :reviewer
  
  #has one hostprofile
  has_one :hostprofile, dependent: :destroy
  
  has_many :forumposts, dependent: :destroy
  
  #has requested appointments with hosts
  has_many :requested_appts, class_name: "Appointment", foreign_key: "traveler_id", dependent: :destroy
  
  #has many messages
  has_many :received, class_name:"Message", foreign_key: "recipient_id"
  has_many :sent, class_name: "Message", foreign_key: "sender_id"
  
  before_save :create_tokens
  before_save {|user| user.email = email.downcase}
  
  attr_writer :old_password
  #TODO remove these for production
  #validates :firstname, presence:true, length:{maximum: 20}
  #validates :lastname, presence: true, length:{maximum: 20}
  
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format:{with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
  validates_uniqueness_of :email
  

  #validates :password, length:{minimum: 6}
  #validates :password_confirmation, presence: true
  
  MAX_NUM_PICTURES = 7;
  
  def sent_msgs
    self.sent.where(:owner_id => self.id) 
  end
  
  def received_msgs
    self.received.where(:owner_id => self.id)
  end
  
  def calc_host_avg_score
     count = self.inverse_reviews.count
     if count == 0
        return 0
     else
        debugger
        avg = self.inverse_reviews.collect(&:score).sum.to_f/count if count > 0     
        return (avg * 10).round.to_f / 10
     end
  end
  
  def meetups_completed
     if self.hostprofile
        return self.completed_count + self.hostprofile.completed_count
     else
        return self.completed_count  
     end
  end
  
  def id_num
    self.id
  end
  
  def calc_guest_abg_score
  end
  
  def at_max_picture?
    self.images.count == MAX_NUM_PICTURES
  end
  def toggle_host_status
    self.toggle!(:is_host)
  end
  
  def toggle_confirm_status
    self.toggle!(:confirmed)
  end
  
  def confirm_status?(token) 
    if token && token == self.confirmation_token
      self.toggle_confirm_status
      return true
    else
      return false
    end
  end
  
  def set_default_profile_pic
    if self.profile_pic_id.nil? 
      self.profile_pic_id = self.images.first.nil? ? nil : self.images.first.id  
    end
  end

  private

  def create_tokens
    self.remember_token = SecureRandom.urlsafe_base64
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
  
  
  
end

User.includes([:sent_msgs, :received_msgs])

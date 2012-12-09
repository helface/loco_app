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
  has_secure_password
  
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation, :profile_pic_id, :self_intro
  attr_accessible :birthday, :gender, :facebook, :languages, :language_tokens
  serialize :languages
  attr_accessor  :language_tokens
  attr_writer :old_password
  
  
  has_many :images, :dependent => :destroy
  
  #has many reviews
  has_many :reviews, foreign_key: "reviewer_id", dependent: :destroy
  
  #has received many reviews
  has_many :inverse_reviews, class_name: "Review", foreign_key: "reviewee_id"
  
  #has one hostprofile
  has_one :hostprofile, dependent: :destroy
  
  has_many :forumposts, dependent: :destroy
  
  #has requested appointments with hosts
  has_many :requested_appts, class_name: "Appointment", foreign_key: "traveler_id", dependent: :destroy
  
  #has many messages
  has_many :received, class_name:"Message", foreign_key: "recipient_id"
  has_many :sent, class_name: "Message", foreign_key: "sender_id"
  
  #TODO:test if deleting a user deletes his copy of message
  has_many :messages, foreign_key: "owner_id", dependent: :destroy
  #has many reviews as travelers
  
  has_many :treviews_written, class_name: "Travelerreview", foreign_key: "reviewer_id"
  has_many :treviews_received, class_name: "Travelerreview", foreign_key: "reviewee_id", dependent: :destroy
  
  before_save :create_tokens
  before_save {|user| user.email = email.downcase}
  
  validates_presence_of :languages, :if => :is_host? 
  #TODO remove these for production
  #validates :firstname, presence:true, length:{maximum: 20}
  #validates :lastname, presence: true, length:{maximum: 20}
  
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format:{with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}
  validates_uniqueness_of :email

  #validates :password, length:{minimum: 6}
  #validates :password_confirmation, presence: true
  
  MAX_NUM_PICTURES = 7; 
  GENDER = {'female'=>1, "male" => 2}

  def calc_avg_traveler_score(score)
     count = self.treviews_received.count
     sum = (((count-1) * self.traveler_score + score ) / count).to_f unless count == 0
     self.traveler_score = (sum * 10).round / 10.to_f unless count == 0 
     self.save
  end
  def calc_age
     now = Time.now.utc.to_date
     age = Date.today.year - birthday.year
     age -= 1 if Date.today < birthday + age.years
     return age
  end
  
  def is_host?
    return self.is_host
  end
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
        avg = self.inverse_reviews.collect(&:score).sum.to_f/count if count > 0     
        return (avg * 10).round.to_f / 10
     end
  end
  
  def active_meetup_count
    if self.hostprofile
      self.hostprofile.appt_requests.active.where("host_completed = ?", false).count + self.requested_appts.active.where("traveler_completed = ?", false).count
    else
      self.requested_appts.active.count
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
  
  def language_tokens=(langs)
    self.languages = langs.split(",")
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

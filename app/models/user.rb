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
  
  #TODO: make is_host non accessible
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation
  has_secure_password
  has_attached_file :photo
  
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
  
  #has many messages
  has_many :received_msgs, class_name:"Message", foreign_key: "recipient_id"
  has_many :sent_msgs, class_name: "Message", foreign_key: "sender_id"
  
  #validate
  validates_associated :reviews
  validates_associated :reviewees, :through => :reviews
  
  before_save :create_tokens
  before_save {|user| user.email = email.downcase}
  
  validates :firstname, presence:true, length:{maximum: 20}
  validates :lastname, presence: true, length:{maximum: 20}
  
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}

  validates :password, length:{minimum: 6}
  validates :password_confirmation, presence: true
  
  private
  
  def create_tokens
    self.remember_token = SecureRandom.urlsafe_base64
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
  
end

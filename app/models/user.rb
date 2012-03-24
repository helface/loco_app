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
  
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  
  validates :firstname, presence:true, length:{maximum: 20}
  validates :lastname, presence: true, length:{maximum: 20}
  
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}

  validates :password, length:{minimum: 6}
  validates :password_confirmation, presence: true
  
  private
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  firstname  :string(255)
#  lastname   :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  
  attr_accessible :firstname, :lastname, :email, :username
  
  validates :username, presence: true, length:{maximum:24}, uniqueness:{case_sensitive: false}
  validates :firstname, presence:true, length:{maximum: 20}
  validates :lastname, presence: true, length:{maximum: 20}
  
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format:{with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive:false}

  #def initialize (attributes ={})
   # @username = attributes[:username]
    #@firstname = attributes[:firstname]
    #@lastname = attributes[:lastname]
    #@email = attributes[:email]
  #end
end

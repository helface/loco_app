class User < ActiveRecord::Base
  
  #attr_accessor :username, :firstname, :lastname, :email
  
  validates :username, :presence => true
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :email, :presence => true

  
  #def initialize (attributes ={})
   # @username = attributes[:username]
    #@firstname = attributes[:firstname]
    #@lastname = attributes[:lastname]
    #@email = attributes[:email]
  #end
end

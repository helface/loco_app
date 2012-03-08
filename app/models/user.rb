class User < ActiveRecord::Base
  validates :username, :presence => true
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :email, :presence => true
end

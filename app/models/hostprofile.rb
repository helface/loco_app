class Hostprofile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :tele, :serviceDesc, :aboutme, :price, :greenDesc
  
  validates :serviceDesc, presence: true
  validates :aboutme, presence: true, length: {maximum: 500}
  validates :greenDesc, presence: true, length: {maximum: 500}

  #Add verification for input here
end

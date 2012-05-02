class Hostprofile < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  #belongs_to :service
  attr_accessible :tele, :serviceDesc, :aboutme, :price, :greenDesc, :city_id, :country_id
  
  validates :serviceDesc, presence: true
  validates :aboutme, presence: true, length: {maximum: 500}
  validates :greenDesc, presence: true, length: {maximum: 500}

  #Add verification for input here
  #add options for displayng phone number
end

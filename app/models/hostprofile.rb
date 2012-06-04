class Hostprofile < ActiveRecord::Base
  scope :by_service, lambda { |service| where(:service => service) }
  belongs_to :user
  belongs_to :city
  #belongs_to :service
  attr_accessible :tele, :serviceDesc, :service, :aboutme, :price, :greenDesc, :city_id, :country_id
  
  validates :serviceDesc, presence: true
  validates :aboutme, presence: true, length: {maximum: 500}
  validates :greenDesc, presence: true, length: {maximum: 500}

  #Add verification for input here
  #add options for displayng phone number
end

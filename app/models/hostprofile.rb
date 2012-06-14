class Hostprofile < ActiveRecord::Base
  scope :by_service, lambda { |service| where(:service => service) }
  belongs_to :user
  belongs_to :city
  attr_accessible :tele, :languages, :serviceDesc, :service, :aboutme, :price, :greenDesc, :city_id, :country_id
  serialize :languages
  
  before_validation do |hostprofile|
    hostprofile.languages.reject!(&:blank?) if hostprofile.languages
  end
  
  validates_presence_of :languages, :serviceDesc
  validates :aboutme, presence: true, length: {maximum: 500}
  validates :greenDesc, presence: true, length: {maximum: 500}

  #Add verification for input here
  #add options for displayng phone number
end

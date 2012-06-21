class Hostprofile < ActiveRecord::Base
  scope :by_service, lambda { |service| where(:service => service) }
  belongs_to :user
  belongs_to :city
  attr_accessible :language_tokens, :tele, :languages, :serviceDesc, :service, :aboutme, :price, :greenDesc, :city_id, :country_id, :exchange_methods, :other_exchange
  attr_reader :language_tokens
  serialize :languages
  
  before_validation do |hostprofile|
    hostprofile.languages.reject!(&:blank?) if hostprofile.languages
  end
  
  validates_presence_of :languages, :serviceDesc
  validates :aboutme, presence: true, length: {maximum: 500}
  validates :greenDesc, presence: true, length: {maximum: 500}

  #Add verification for input here
  #add options for displayng phone number
  EXCHANGE_METHODS = ['money', 'just to make a new friend', 'language practice', 'negotiable']
  def calc_response_rate
    if contacted_count > 0
      (self.responded_count/self.contacted_count)*100
    end
  end
  
  def language_tokens=(langs)
    self.language_tokens = langs.split(",")
  end
  
end

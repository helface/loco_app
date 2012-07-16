class Hostprofile < ActiveRecord::Base
  attr_accessible :language_tokens, :tele, :languages, :serviceDesc, :service, :aboutme, :price, :greenDesc, :city_id, :country_id, :currency, :exchange_type
  scope :by_service, lambda { |service| where(:service => service) }
  belongs_to :user
  belongs_to :city
  serialize :languages
  attr_accessor  :language_tokens
  
  attr_writer :current_step
  
  validates_presence_of :languages, :serviceDesc
  validates :aboutme, presence: true, length: {maximum: 500}
  validates :greenDesc, presence: true, length: {maximum: 500}
  
  #before_validation do |hostprofile|
   # hostprofile.languages.reject!(&:blank?) if hostprofile.languages
  #end
  

  EXCHANGE_TYPES = ['money', 'making a new friend (free)', 'language practice', 'negotiable']
  CURRENCIES = ['usd', 'euro']
  
  def calc_response_rate
    if contacted_count > 0
      (self.responded_count/self.contacted_count)*100
    end
  end
  
  def language_tokens=(langs)
    self.languages = langs.split(",")
  end
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
     %w[host_information service_information]
  end
  
  def next_step
     self.current_step = steps[steps.index(current_step) + 1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end
end

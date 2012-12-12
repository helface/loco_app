class Hostprofile < ActiveRecord::Base
  attr_accessible :language_tokens, :intro, :tele, :serviceDesc, :service, :aboutme
  attr_accessible :price, :greenDesc, :city_id, :country_id, :currency, :exchange_type, :language_practice
  
  has_many :appt_requests, class_name: "Appointment", foreign_key: "host_id", dependent: :destroy
  scope :by_service, lambda { |service| where(:service => service) }
  belongs_to :user
  belongs_to :city
  serialize :languages
  attr_accessor  :language_tokens
  attr_writer :current_step
  
  #has appointment requests from travelers
  
  #validates_presence_of :languages, :serviceDesc
  validates :greenDesc, presence: true, length: {maximum: 2000}
  validates :intro, presence: true, length: {maximum: 140}
  validates :serviceDesc, presence:true, length: {maximum: 2000}
  validates_presence_of :city_id, :country_id
  validates_presence_of :price, :currency, :if => :exchange_is_money?
  validates_presence_of :language_practice, :if =>:exchange_is_lang?
  validate :language_filled
   
  #before_validation do |hostprofile|
   # hostprofile.languages.reject!(&:blank?) if hostprofile.languages
  #end
  

  EXCHANGE_TYPES = ['money', 'making a new friend (free)', 'language practice', 'negotiable']
  CURRENCIES = ['usd', 'euro']
  
  def language_filled
    errors.add(:language_tokens, 'Host must enter languages they can speak') unless self.languages_filled
  end
 
  def calc_response_rate
     if self.contacted_count == 0
        return 0
     else
        (self.responded_count.to_f/self.contacted_count.to_f * 100).to_i
     end
  end
  
  def calc_recommend_rate
    if self.completed_count == 0
       return 0
    else
       (self.recommend_count/self.completed_count * 100).to_i
    end 
  end
  
  def increment_contact_count
    self.increment!(:contacted_count)
  end
  
  def increment_response_count
    self.increment!(:responded_count)
  end
  
  def increment_completed_count
    self.increment!(:completed_count)
  end
  
  def update_recommend_count(recommend)
    if recommend == true
       self.increment!(:recommend_count)
    else
       self.increment!(:unrecommend_count)
    end
  end
  
  def calc_host_avg_score(score, count)
     sum = (((count-1) * self.score + score ) / count).to_f unless count == 0
     self.score = (sum * 10).round / 10.to_f unless count == 0 
     self.save
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
  
  private
  
  def exchange_is_money?
    exchange_type == "money"
  end
  
  def exchange_is_lang?
    exchange_type == "language practice"
  end
  
end

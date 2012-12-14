class Forumpost < ActiveRecord::Base
  attr_accessible :city_id, :country_id, :title, :content, :date, :price, :currency, :pay
  belongs_to :city
  belongs_to :user
  validates_inclusion_of :pay, :in=>[false, true]
  
  validates_presence_of :city_id, :country_id, :date
  validates_presence_of :content, length: {maximum: 2000}
  validates_presence_of :title, length:{maximum: 70}
  validate :correct_date
  validates_presence_of :price, :currency, if: Proc.new{|forumpost| forumpost.pay == true}
  
  before_save :verify_location, Proc.new{|forumpost| forumpost.pay == false unless forumpost.pay == true}
  
  WILL_PAY = {"no" => false, 'yes'=> true}
    
  def increment_respond_count
    self.increment!(:responded_count)  
  end 
  
  def verify_location
     city = City.find_by_id(self.city_id)
     country = Country.find_by_id(self.country_id)
     city.is_city_of(country) unless city.nil? || country.nil?
  end
  
  private
  
  def correct_date
    errors.add(:date, 'meeting date must be later than today') unless self.date.nil? || self.date > DateTime.now
  end
end

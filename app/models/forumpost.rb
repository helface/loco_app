class Forumpost < ActiveRecord::Base
  attr_accessible :city_id, :country_id, :title, :content, :date
  belongs_to :city
  belongs_to :user
  
  validates_presence_of :city_id
  validates_presence_of :country_id
  validates_presence_of :content, length: {maximum: 400}
  validates_presence_of :title, length:{maximum: 70}
  validates_presence_of :date
  validate :correct_date
  
  before_save :verify_location
    
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
    errors.add(:date, 'meeting date must be later than today') unless self.date > DateTime.now
  end
end

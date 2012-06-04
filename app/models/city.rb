class City < ActiveRecord::Base
  attr_accessible :name, :country_id
  belongs_to :country
  has_many :hostprofiles
  has_many :hosts, through: :hostprofiles, source: :user
  has_many :forumposts
  
  def is_city_of(country)
    self.country == country
  end
  
end

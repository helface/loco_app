class City < ActiveRecord::Base
  attr_accessible :name, :country_id, :timezone
  belongs_to :country
  has_many :hostprofiles, conditions: ["hostprofiles.deactivated = ?", false]
  has_many :hosts, through: :hostprofiles, source: :user, conditions: ["users.deactivated = ?", false]
  has_many :forumposts
  
  def is_city_of(country)
    self.country == country
  end
  
end

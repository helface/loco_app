class City < ActiveRecord::Base
  attr_accessible :name, :country_id
  belongs_to :country
  has_many :hostprofiles
  has_many :hosts, through: :hostprofiles, source: :user
end

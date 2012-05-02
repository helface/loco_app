class Country < ActiveRecord::Base
  attr_accessible :name, :code
  has_many :cities
end

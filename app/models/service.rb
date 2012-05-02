#TODO: put constraints on the attributes

class Service < ActiveRecord::Base
  attr_accessible :title, :desc
end

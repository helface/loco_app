class Travelerreview < ActiveRecord::Base
  attr_accessible :comment, :score
  belongs_to :user
  validates_presence_of :score
end

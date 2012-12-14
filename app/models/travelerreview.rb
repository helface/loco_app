class Travelerreview < ActiveRecord::Base
  attr_accessible :comment, :score
  belongs_to :user
  validates_presence_of :score
  validates :comment, length:{maximum: 500}
end

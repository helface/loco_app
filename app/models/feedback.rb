class Feedback < ActiveRecord::Base
  attr_accessible :content
  validates :content, length: {maximum: 500}
end

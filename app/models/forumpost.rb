class Forumpost < ActiveRecord::Base
  attr_accessible :city_id, :country_id, :title, :content
  belongs_to :city
  belongs_to :user
  
  validates_presence_of :city_id
  validates_presence_of :country_id
  validates_presence_of :content, length: {maximum: 200}
  
  def increment_respond_count
    self.increment!(:responded_count)  
  end 
  
end

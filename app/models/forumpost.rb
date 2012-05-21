class Forumpost < ActiveRecord::Base
  attr_accessible :city_id, :country_id, :title, :content
   belongs_to :city
   belongs_to :user
end

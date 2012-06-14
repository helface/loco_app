class Review < ActiveRecord::Base
   attr_accessible :content, :reviewer_id, :reviewee_id
   
   belongs_to :reviewer, :class_name => "User"
   belongs_to :reviewee, :class_name => "User"  
    
   validates_presence_of :reviewer_id, :reviewee_id
   validates :content, presence: true, length: {maximum: 500}
   default_scope order: 'reviews.created_at DESC'
end

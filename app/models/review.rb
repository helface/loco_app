class Review < ActiveRecord::Base
   attr_accessible :content, :reviewer_id, :reviewee_id
   #attr_accessible :content
    
   #belongs_to :user
   belongs_to :reviewer, :class_name => "User"
   belongs_to :reviewee, :class_name => "User"  
    
   validates :reviewer_id, presence: true
   validates :reviewee_id, presence: true
   validates :content, presence: true, length: {maximum: 500}
    
   default_scope order: 'reviews.created_at DESC'
end

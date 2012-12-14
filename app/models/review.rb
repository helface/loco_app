class Review < ActiveRecord::Base
   attr_accessible :content, :recommend, :accuracy, :friendliness, :enjoybility, :easiness
   
   #TODO:remove this for production
   attr_accessible :reviewer_id, :reviewee_id
   
   belongs_to :reviewer, :class_name => "User"
   belongs_to :reviewee, :class_name => "User"  
    
   validates_presence_of :reviewer_id, :reviewee_id
   validates_presence_of :accuracy, :friendliness, :enjoybility, :easiness, message: "answer can't be blank" 
   validates :accuracy, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
   validates :friendliness, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
   validates :enjoybility, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
   validates :easiness, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
   validates :content, length:{maximum: 2000}
   default_scope order: 'reviews.created_at DESC'
   
   validates_inclusion_of :recommend, :in=>[true, false]
  
   def calculate_score
   end
   
   def is_host_review?
    self.is_host_review == true
   end
   
   def is_guest_review?
    self.is_host_review == false
   end
end

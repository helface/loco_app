class Review < ActiveRecord::Base
   attr_accessible :is_host_review, :guest_score, :content, :recommend, :accuracy, :friendliness, :enjoybility, :easiness
   
   #TODO:remove this for production
   attr_accessible :reviewer_id, :reviewee_id
   
   belongs_to :reviewer, :class_name => "User"
   belongs_to :reviewee, :class_name => "User"  
    
   validates_presence_of :reviewer_id, :reviewee_id
   
   validates_presence_of :accuracy, :friendliness, :enjoybility, :easiness, :if => :is_host_review?, message: "answer can't be blank" 
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
     
   #verify guest review content and score are present
    with_options :if => :is_guest_review? do |review|
      review.validates :content, presence: true
      review.validates :guest_score, presence: true
    end

    #verify that review questions are all answered
    with_options :if => :is_host_review? do |review|
      review.validates :accuracy, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
      review.validates :friendliness, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
      review.validates :enjoybility, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
      review.validates :easiness, :numericality=>{:only_integer => true, :greater_than_or_equal_to=>1, :less_than_or_equal_to=>5}
    end
end

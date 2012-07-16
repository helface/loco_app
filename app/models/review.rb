class Review < ActiveRecord::Base
   attr_accessible :is_host_review, :guest_score, :content, :recommend, :accuracy, :friendliness, :enjoybility, :easiness
   belongs_to :reviewer, :class_name => "User"
   belongs_to :reviewee, :class_name => "User"  
    
   validates_presence_of :reviewer_id, :reviewee_id
   
   default_scope order: 'reviews.created_at DESC'
   
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
      review.validates :accuracy, :numericality=>{:greater_than=>0}
      review.validates :friendliness, :numericality=>{:greater_than=>0}
      review.validates :enjoybility, :numericality=>{:greater_than=>0}
      review.validates :easiness, :numericality=>{:greater_than=>0}
    end
end

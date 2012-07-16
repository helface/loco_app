class ReviewsController < ApplicationController

before_filter :signed_in_user, only: :create
before_filter :admin_user, only: :destroy
    
def create
   @review = Review.new(params[:review])
   @review.reviewer_id = current_user.id
   @review.reviewee_id = params[:user_id]
   rev = params[:review]
   score = (2*rev[:accuracy].to_f + rev[:friendliness].to_f + rev[:easiness].to_f + 2*rev[:enjoybility].to_f) / 6
   debugger
   
   @review.score = score
   if @review.save
      flash[:success] = "Review successfully submitted"
      redirect_to user_path(params[:user_id])
   else
      flash[:error] = "Comment could not be posted"
      redirect_to root_path
   end
   
end
    
def destroy
  @review.destroy
end
    
private
   def admin_user
      redirect_to(root_path) unless current_user.admin? && !current_user?(@user)
   end
end

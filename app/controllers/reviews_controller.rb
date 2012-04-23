class ReviewsController < ApplicationController
   #before_filter :not_user_sel, only: :create
before_filter :signed_in_user, only: :create
before_filter :admin_user, only: :destroy
    
def create
   @review = Review.new(params[:review])
   if @review.save
      flash[:success] = "Review successfully submitted"
      redirect_to user_path(params[:review][:reviewee_id])
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

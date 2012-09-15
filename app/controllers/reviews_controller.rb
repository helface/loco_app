class ReviewsController < ApplicationController

before_filter :signed_in_user, only: [:create, :new] 
before_filter :admin_user, only: :destroy

def new
  @user = User.find_by_id(params[:user_id])
  @review = Review.new
end

def create
   @user = User.find_by_id(params[:user_id])
   @review = Review.new(params[:review])
   @review.reviewer_id = current_user.id
   @review.reviewee_id = params[:user_id]
   @review.score = calc_score   
   if @review.save
      user = User.find_by_id(params[:user_id])     
      user.hostprofile.update_recommend_count(params[:review][:recommend])
      user.hostprofile.calc_host_avg_score(@review.score, user.inverse_reviews.count)
      flash[:success] = "Review successfully submitted"
      redirect_to user_path(params[:user_id])
   else
      flash[:error] = "Review could not be posted."
      render 'new'
   end
   
end
    
def destroy
  @review.destroy
end
    
private
   def admin_user
      redirect_to(root_path) unless current_user.admin? && !current_user?(@user)
   end
   
   def calc_score
     rev = params[:review]       
     score = (2*rev[:accuracy].to_f + rev[:friendliness].to_f + rev[:easiness].to_f + 2*rev[:enjoybility].to_f) / 6
     round_score = (score * 10).round / 10.to_f 
   end
   
end

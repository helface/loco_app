class TravelerreviewsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :new] 

  def new
    @user = User.find_by_id(params[:user_id])
    @review = Travelerreview.new
  end

  def create
     @user = User.find_by_id(params[:user_id])
     @review = Travelerreview.new(params[:travelerreview])
     @review.reviewer_id = current_user.id
     @review.reviewee_id = params[:user_id]
     if @review.save
        user = User.find_by_id(params[:user_id])     
        flash[:success] = "Review successfully submitted"
        redirect_to session[:prev]
     else
        flash[:error] = "Review could not be posted."
        render 'new'
     end
  end

  def destroy
    @review = Travelerreview.find_by_id(params[:id])
    @review.destroy
  end
  
end

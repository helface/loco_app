class FeedbacksController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user
  
  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.save unless params[:feedback][:content].empty?
    redirect_to deactivate_user_path(@user)
  end
  
  private
  
  def correct_user
    @user = User.find_by_id(params[:user_id])
    redirect_to root_path unless current_user?(@user)
  end
end

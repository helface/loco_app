class MessagesController < ApplicationController
before_filter :signed_in_user
#before_filter :unique_to_from, only: [:create]

  def new
    @user = User.find(params[:user_id])
    @message = Message.new
  end

  def create  
    @user = User.find(params[:user_id])
    build_message_thread
  end

  def show
  end
  
end

private

#def unique_to_from
#  if User.find(params[:message][:recipient_id]) == current_user
#    redirect_to root_path
#  end
#end


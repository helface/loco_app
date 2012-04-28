class MsgthreadsController < ApplicationController
  
  def new
    
  end

  def create
    if Msgthread.create!(params[:msgthread])
      if @message.save
        flash[:success] = "your message has been sent"
        redirect_to User.find(params[:message][:recipient_id])
      else
        flash[:error] = "Sorry, we were unable to send your message"
        redirect_to current_user
      end
    end
  end

  def show
    @msgthread = Msgthread.find(params[:id])
    @messages = @msgthread.messages
  end
end

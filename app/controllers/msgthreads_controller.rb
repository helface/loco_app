class MsgthreadsController < ApplicationController
  def new
    @msgthread = Msgthread.new
  end
  def show
    @msgthread = Msgthread.find(params[:id])
    recipient_id = @msgthread.find_recipient_id(current_user)
    @recipient = User.find_by_id(recipient_id)    
    @messages = @msgthread.messages.order('created_at DESC')
  end
end

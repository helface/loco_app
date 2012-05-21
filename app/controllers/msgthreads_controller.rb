class MsgthreadsController < ApplicationController
  def new
    @msgthread = Msgthread.new
  end
  def show
    @user = User.find(params[:user_id])
    @msgthread = Msgthread.find(params[:id])
    @messages = @msgthread.messages
  end
end

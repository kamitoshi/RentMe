class MessagesController < ApplicationController

  def create
    @room = Room.find(params[:id])
    @message = @room.messages.build(message_params)
    if worker_signed_in?
      @message.user = "worker"
      if @message.save
        render :send
      else
        redirect_back(fallback_location: root_path)
      end
    elsif employer_signed_in?
      @message.user = "employer"
      byebug
      if @message.save
        byebug
        render :send
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    
  end

  private
  def message_params
    params.require(:message).permit(:room_id, :content, :user)
  end

end

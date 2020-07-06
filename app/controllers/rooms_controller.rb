class RoomsController < ApplicationController
  
  def index
    if worker_signed_in?
      @rooms = Room.where(worker_id: current_worker.id)
      @message = Message.new
    elsif employer_signed_in?
      @rooms = Room.where(employer_id: current_employer.id)
      @message = Message.new
    end
  end

  def show
    if worker_signed_in?
      @rooms = Room.where(worker_id: current_worker.id)
      @room = Room.find(params[:id])
      @message = Message.new
    elsif employer_signed_in?
      @rooms = Room.where(employer_id: current_employer.id)
      @room = Room.find(params[:id])
      @message = Message.new
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if worker_signed_in?
      if @room.update(worker_id: nil)
        if @room.worker_id == nil && @room.employer_id == nil
          @room.destroy
        end
        flash[:success] = "チャットルームから退室しました"
        redirect_to rooms_path
      else
        flash[:danger] = "チャットルームから退出できませんでした"
        redirect_to rooms_path
      end
    elsif employer_signed_in?
      if @room.update(employer_id: nil)
        if @room.worker_id == nil && @room.employer_id == nil
          @room.destroy
        end
        flash[:success] = "チャットルームから退室しました"
        redirect_to rooms_path
      else
        flash[:danger] = "チャットルームから退出できませんでした"
        redirect_to rooms_path
      end
    end
  end

end

class LikesController < ApplicationController
  before_action :only_employer!

  def index
    @likes = Like.where(employer_id: current_employer.id)
  end

  def create
    @worker = Worker.find(params[:worker_id])
    @like = current_employer.likes.build(worker_id: @worker.id)
    if @like.save
      render :add_like
    else
      redirect_to employers_path
    end
  end

  def destroy
    @worker = Worker.find(params[:worker_id])
    @like = Like.find(params[:id])
    if @like.destroy
      @like = nil
      render :remove_like
    else
      redirect_to employers_path
    end
  end

  private
  def only_employer!
    unless employer_signed_in?
      redirect_to root_path
    end
  end

end

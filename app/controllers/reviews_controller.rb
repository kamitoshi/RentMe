class ReviewsController < ApplicationController

  def index
    if worker_signed_in?
      @reviews = Review.where(worker_id: current_worker.id)
    elsif employer_signed_in?
      if params[:worker_id].present?
        @reviews = Review.where(worker_id: params[:worker_id])
      end
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @contract = Contract.find(params[:contract_id])
    @worker = @contract.worker
    if employer_signed_in?
      @like = current_employer.likes.find_by(worker_id: @worker.id)
    end
    @review = Review.new
  end

  def create
    @contract = Contract.find(params[:contract_id])
    @review = current_employer.reviews.build(review_params)
    if @review.save
      @contract.update(status: 2) 
      flash[:success] = "レビューしました"
      redirect_to employers_path
    else
      flash.now[:danger] = "レビューに失敗しました"
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:worker_id, :employer_id, :contract_id, :service_rate, :skill_rate, :voice_rate, :earnest_rate, :smile_rate, :detail)
  end

end

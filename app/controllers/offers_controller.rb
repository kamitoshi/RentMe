class OffersController < ApplicationController

  before_action :set_offer, only:[:show, :confirm, :edit, :update, :apply, :approval, :destroy]

  def index
    
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def confirm

  end

  def create
    @offer = current_employer.offers.build(offer_params)
    @offer.suggest_id = params[:suggest_id]
    if @offer.save
      flash[:success] = "オファーしました"
      redirect_to confirm_offer_path(@offer)
    else
      flash[:danger] = "オファーできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    unless @offer.employer == current_employer
      flash[:danger] = "他店舗のオファーは編集できません"
      redirect_to employer_path(current_employer)
    end
  end

  def update
    if @offer.employer == current_employer
      if @offer.is_apply?
        flash[:danger] = "このオファーは申請中です。編集するには、申請を一度取り下げてください。"
        redirect_to edit_offer_path(@offer)
      else
        if @offer.update(offer_params)
          flash[:success] = "オファー内容を編集しました"
          redirect_to offer_path(@offer)
        else
          flash.now[:danger] = "オファー内容を編集できませんでした"
          render :edit
        end
      end
    else
      flash[:danger] = "他店舗のオファーは編集できません"
      redirect_to employer_path(current_employer)
    end
  end

  def apply
    if @offer.employer == current_employer
      if @offer.is_apply?
        if @offer.update(is_apply: false)
          flash[:success] = "オファーを取り下げました"
          redirect_to offer_path(@offer)
        else
          flash.now[:danger] = "オファーの取り下げることができませんでした"
          redirect_to offer_path
        end
      else
        flash[:danger] = "すでに取り下げられています"
      end
    else
      flash[:danger] = "他店舗のオファーは取り下げることができません"
      redirect_to employer_path(current_employer)
    end
  end

  def approval
    if @offer.suggest.worker == current_worker
      if params[:approval] == "1"
        @offer.update(is_approval: true)
        flash[:success] = "オファーを承認しました"
        redirect_to offer_path(@offer)
      elsif params[:approval] == "0"
        @offer.update(is_approval: false)
        flash[:danger] = "オファーを拒否しました"
        redirect_to worker_path(current_worker)
      end 
    else
      flash[:danger] = "自分にきたオファー以外回答できません"
      redirect_to worker_path(current_worker)
    end
  end
  
  def destroy
    if @offer.employer == current_employer
      if @offer.is_apply?
        flash[:danger] = "このオファーは申請中です。削除するには申請を取り下げてください。"
        redirect_to offer_path(@offer)
      else
        if @offer.destroy
          flash[:success] = "オファーを削除しました"
          redirect_to employer_path(current_employer)
        else
          flash[:danger] = "オファーの削除に失敗しました"
          redirect_to offer_path(@offer)
        end
      end
    else
      flash[:danger] = "他店舗のオファーは削除できません"
    end
  end

  private
  def offer_params
    params.require(:offer).permit(:suggest_id, :employer_id, :price, :opening, :closing, :content, :is_apply, :is_approval)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end

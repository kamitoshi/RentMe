class OffersController < ApplicationController
  before_action :only_worker!, only:[:approval]
  before_action :only_employer!, only:[:new, :confirm, :create, :edit, :apply, :destroy]
  before_action :set_offer, only:[:show, :confirm, :edit, :update, :apply, :approval, :destroy]

  def index
    
  end

  def show
  end

  def new
    @suggest = Suggest.find(params[:suggest_id])
    if @suggest.is_active?
      @offer = Offer.new
    else
      flash[:danger] = "契約済みの案件です"
      redirect_back(fallback_location: root_path)
    end
  end

  def confirm

  end

  def create
    @suggest = Suggest.find(params[:suggest_id])
    if @suggest.is_active?
      @offer = current_employer.offers.build(offer_params)
      @offer.suggest_id = @suggest.id
      @offer.job_description = params[:offer]["job_description"][0]
      if @offer.save
        flash[:success] = "オファーしました"
        redirect_to confirm_offer_path(@offer)
      else
        flash.now[:danger] = "オファーできませんでした"
        render :new
      end
    else
      flash[:danger] = "掲載が終了しています"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @suggest = @offer.suggest
    unless @offer.employer == current_employer
      flash[:danger] = "他店舗のオファーは編集できません"
      redirect_to employers_path
    end
  end

  def update
    if @offer.employer == current_employer
      if @offer.is_apply?
        flash[:danger] = "このオファーは申請中です。編集するには、申請を一度取り下げてください。"
        redirect_to edit_offer_path(@offer)
      else
        job_description
        if @offer.update(offer_params)
          @offer.is_apply = 1
          @offer.save
          flash[:success] = "オファー内容を編集しました"
          redirect_to offer_path(@offer)
        else
          flash.now[:danger] = "オファー内容を編集できませんでした"
          render :edit
        end
      end
    else
      flash[:danger] = "他店舗のオファーは編集できません"
      redirect_to employers_path
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
          redirect_to offer_path(@offer)
        end
      else
        flash[:danger] = "すでに取り下げられています"
      end
    else
      flash[:danger] = "他店舗のオファーは取り下げることができません"
      redirect_to employers_path
    end
  end

  def approval
    if @offer.suggest.worker == current_worker
      if params[:approval] == "1"
        @offer.update(is_approval: true)
        @offer.all_delete
        @offer.suggest.update(is_active: false)
        flash[:success] = "オファーを承認しました"
        redirect_to new_offer_contract_path(@offer)
      elsif params[:approval] == "0"
        @offer.update(is_approval: false)
        flash[:danger] = "オファーを拒否しました"
        redirect_to workers_path
      end 
    else
      flash[:danger] = "自分にきたオファー以外回答できません"
      redirect_to workers_path
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
          redirect_to employers_path
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
    params.require(:offer).permit(:suggest_id, :employer_id, :price, :job_description, :opening, :closing, :content, :is_apply, :is_approval)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def job_description
    if params[:offer]["description"]
      params[:offer]["description"] = params[:offer]["description"][0]
    end
  end

  def only_worker!
    unless worker_signed_in?
      redirect_to root_path
    end
  end

  def only_employer!
    unless employer_signed_in?
      redirect_to root_path
    end
  end

end

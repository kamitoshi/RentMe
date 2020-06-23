class SuggestsController < ApplicationController
  before_action :set_suggest, only:[:show, :edit, :update, :destroy]

  def index
    @suggests = Suggest.all
  end

  def show
  end

  def new
    @suggest = Suggest.new
  end

  def create
    @suggest = current_worker.suggests.build(suggest_params)
    if @suggest.save
      flash[:success] = "掲載しました"
      redirect_to worker_path(current_worker)
    else
      flash.now[:alert] = "掲載できませんでした"
      render :new
    end
  end

  def edit
    redirect_to worker_path(current_worker) unless current_worker == @suggest.worker
  end

  def update
    if @suggest.worker == current_worker
      if @suggest.update(suggest_params)
        flash[:success] = "掲載情報を編集しました"
        redirect_to suggest_path(@suggest)
      else
        flash[:alert] = "掲載情報を編集できませんでした"
        render :edit
      end
    else
      flash[:alert] = "自分以外の掲載は編集できません"
      redirect_to worker_path(current_worker)
    end
  end

  def destroy
    if @suggest.worker == current_worker
      if @suggest.destroy
        flash[:success] = "掲載情報を削除しました"
        redirect_to worker_path(current_worker)
      else
        flash[:alert] = "掲載情報を削除できませんでした"
        redirect_to worker_path(current_worker)
      end
    else
      flash[:alert] = "自分以外の掲載情報は削除できません"
      redirect_to worker_path(current_worker)
    end
  end

  private
  def suggest_params
    params.require(:suggest).permit(:title, :detail, :price, :target_date, :opening, :closing, :status, {type_ids:[]})
  end

  def set_suggest
    @suggest = Suggest.find(params[:id])
  end

end

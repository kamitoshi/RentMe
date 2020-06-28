class SuggestsController < ApplicationController
  before_action :only_worker!, only:[:new, :create, :edit, :update, :destroy]
  before_action :set_suggest, only:[:show, :edit, :update, :destroy]

  def index
    if worker_signed_in?
      @suggests = Suggest.where(worker_id: current_worker.id)
    elsif employer_signed_in?
      @suggests = Suggest.all
    end
  end

  def show
    if employer_signed_in?
      @hold = @suggest.holds.find_by(employer_id: current_employer.id)
    end
  end

  def new
    @suggest = Suggest.new
    @location = Location.new
  end

  def create
    @suggest = current_worker.suggests.build(suggest_params)
    if @suggest.save
      flash[:success] = "掲載しました"
      redirect_to workers_path
    else
      flash.now[:alert] = "掲載できませんでした"
      render :new
    end
  end

  def edit
    redirect_to workers_path unless current_worker == @suggest.worker
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
      redirect_to workers_path
    end
  end

  def destroy
    if @suggest.worker == current_worker
      if @suggest.destroy
        flash[:success] = "掲載情報を削除しました"
        redirect_to workers_path
      else
        flash[:alert] = "掲載情報を削除できませんでした"
        redirect_to workers_path
      end
    else
      flash[:alert] = "自分以外の掲載情報は削除できません"
      redirect_to workers_path
    end
  end

  private
  def suggest_params
    params.require(:suggest).permit(:title, :detail, :price, :target_date, :opening, :closing, :status, {type_ids:[]}, {location_ids:[]})
  end

  def set_suggest
    @suggest = Suggest.find(params[:id])
  end

  def only_worker!
    unless worker_signed_in?
      redirect_to employers_path
    end
  end

end

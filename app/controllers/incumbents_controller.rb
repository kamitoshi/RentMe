class IncumbentsController < ApplicationController

  def new
    @incumbent = Incumbent.new
  end

  def create
    @incumbent = Incumbent.new(incumbent_params)
    @incumbent.worker_id = current_worker.id
    if @incumbent.save
      flash[:success] = "アルバイト先を登録しました"
      redirect_to workers_path
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @incumbent = Incumbent.find(params[:id])
  end

  def update
    @incumbent = Incumbent.find(params[:id])
    if params[:is_active] == nil
      @incumbent.is_active = false
    end
    if @incumbent.update(incumbent_params)
      flash[:success] = "アルバイト先情報を編集しました"
      redirect_to workers_path
    else
      flash.now[:danger] = "アルバイト先の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @incumbent = Incumbent.find(params[:id])
    if @incumbent.destroy
      flash[:success] = "削除しました"
      redirect_to workers_path
    else
      flash.now[:danger] = "削除できませんでした"
      redirect_to workers_path
    end
  end

  private
  def incumbent_params
    params.require(:incumbent).permit(:worker_id, :store_name, :description, :is_active)
  end

  def only_worker!
    unless worker_signed_in?
      redirect_to root_path
    end
  end

end

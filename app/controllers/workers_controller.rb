class WorkersController < ApplicationController
  #before_action :authenticate_worker!
  before_action :set_worker, only:[:show, :edit, :image_edit, :update, :destroy]

  def index
    @workers = Worker.all
  end

  def show
  end

  def edit
    redirect_to worker_path(current_worker) unless @worker == current_worker
  end

  def image_edit
    redirect_to worker_path(current_worker) unless @worker == current_worker
  end

  def update
    if @worker == current_worker
      if @worker.update(worker_params)
        flash[:success] = "プロフィールを変更しました"
        redirect_to worker_path(@worker)
      else
        render :edit
      end
    else
      flash[:alert] = "他人のプロフィールは編集できません"
      redirect_to worker_path(current_worker)
    end
  end

  def destroy
    if @worker == current_worker
      if @worker.destroy
        redirect_to delete_path
      else
        flash[:alert] = "退会できませんでした"
        redirect_to worker_path(current_worker)
      end
    else
      flash[:alert] = "他の人を退会させることはできません"
      redirect_to worker_path(current_worker)
    end
  end

  def delete  
  end

  private
  def worker_params
    params.require(:worker).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :sex, :birthday, :phone_number, :prefecture, :city, :street, :building, :email, :introduction, :image)
  end

  def set_worker
    @worker = Worker.find(params[:id])
  end
end

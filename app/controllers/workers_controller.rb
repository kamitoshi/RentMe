class WorkersController < ApplicationController
  before_action :only_worker!, only:[:index, :edit, :image_edit, :update, :destroy, :delete]
  before_action :set_worker, only:[:show, :edit, :image_edit, :update, :destroy]

  def index
    @incumbents = Incumbent.where(worker_id: current_worker.id,).order(is_active: :desc).order(updated_at: :desc)
    @locations = current_worker.locations.order(prefecture: :desc).order(city: :desc)
    suggests = Suggest.where(worker_id: current_worker.id).order(target_date: :asc)
    @suggests = suggests.where(is_active: true)
    @offers = []
    suggests.each do |suggest|
      suggest.offers.each do |offer|
        if offer.is_approval == nil
          @offers.push(offer)
        else
          next
        end
      end
    end
    contracts = Contract.where(worker_id: current_worker.id)
    @reviews = Review.where(worker_id: current_worker.id)
    @contracts = contracts.where(status: 0)
    @review_contracts = contracts.where(status: 1)
  end

  def show
    @reviews = @worker.reviews.sample(4)
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

  def only_worker!
    unless worker_signed_in?
      redirect_to root_path
    end
  end

end

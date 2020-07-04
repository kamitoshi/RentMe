class EmployersController < ApplicationController
  before_action :only_employer!, only:[:index, :edit, :image_edit, :update, :destroy, :delete]
  before_action :set_employer, only:[:show, :edit, :image_edit, :update, :destroy]

  def index
    @offers = Offer.where(employer_id: current_employer.id, is_approval: nil).order(target_date: :asc)
    contracts = Contract.where(employer_id: current_employer.id).order(target_date: :asc)
    @contracts = contracts.where(status: 0)
    @review_contracts = contracts.where(status: 1)
  end

  def show
  end

  def edit
    redirect_to employer_path(current_employer) unless @employer == current_employer
  end

  def image_edit
    redirect_to employer_path(current_employer) unless @employer == current_employer
  end

  def update
    if @employer == current_employer
      if @employer.update(employer_params)
        flash[:success] = "店舗情報を変更しました"
        redirect_to employer_path(@employer)
      else
        render :edit
      end
    else
      flash[:alert] = "他店の情報は編集できません"
      redirect_to employers_path
    end
  end

  def destroy
    if @employer == current_employer
      if @employer.destroy
        redirect_to delete_path
      else
        flash[:alert] = "退会できませんでした"
        redirect_to employer_path(current_employer)
      end
    else
      flash[:alert] = "他店を退会させることはできません"
      redirect_to employers_path
    end
  end

  def delete  
  end

  private
  def employer_params
    params.require(:employer).permit(:store_name, :kana_store_name, :phone_number, :prefecture, :city, :street, :building, :email, :introduction, :image, :url)
  end

  def set_employer
    @employer = Employer.find(params[:id])
  end

  def only_employer!
    unless employer_signed_in?
      redirect_to root_path
    end
  end

end

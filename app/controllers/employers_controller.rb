class EmployersController < ApplicationController
  #before_action :authenticate_employer!
  before_action :set_employer, only:[:show, :edit, :image_edit, :update, :destroy]

  def index
    @employers = Employer.all
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
      redirect_to employer_path(current_employer)
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
      redirect_to employer_path(current_employer)
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
end

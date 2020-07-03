class BanksController < ApplicationController
  before_action :only_worker!

  def index
    @banks = current_worker.banks.order(is_default: :desc).order(updated_at: :desc)
    @bank = Bank.new
  end
  
  def create
    @banks = current_worker.banks.order(is_default: :desc).order(updated_at: :desc)
    if @banks.any?
      @bank = current_worker.banks.build(bank_params)
      if params[:bank]["is_default"]
        @banks.each do |bank|
          if bank.is_default?
            bank.update(is_default: false)
          end
        end
        @bank.is_default = true
      end
    else
      @bank = current_worker.banks.build(bank_params)
      @bank.is_default = true
    end
    if @bank.save
      if @banks.count > 5
        @banks[5].destroy
      end
      flash[:success] = "入金口座を登録しました"
      redirect_to banks_path
    else
      flash.now[:danger] = "登録できませんでした"
      render :index
    end
  end

  def edit
    @banks = current_worker.banks.order(is_default: :desc).order(updated_at: :desc)
    @bank = @banks.find(params[:id])
    unless @bank.worker == current_worker
      flash[:danger] = "他人の口座情報の編集はできません"
      redirect_to root_path
    end
  end

  def update
    @banks = current_worker.banks
    @bank = Bank.find(params[:id])
    if @bank.worker == current_worker
      if @bank.update(bank_params)
        if @bank.is_default?
          @banks.each do |bank|
            if bank != @bank && bank.is_default?
              bank.update(is_default: false)
            end
          end
        end
        flash[:success] = "入金口座の情報を変更しました"
        redirect_to banks_path
      else
        flash[:danger] = "変更できませんでした"
        render :edit
      end
    else
      flash[:danger] = "他人の口座情報は変更できません"
      redirect_to root_path
    end
  end

  def destroy
    @bank = Bank.find(params[:id])
    if @bank.worker == current_worker
      unless @bank.is_default?
        if @bank.destroy
          flash[:success] = "口座情報を削除しました"
          redirect_to banks_path
        else
          flash[:danger] = "口座情報の削除に失敗しました"
          redirect_to banks_path
        end
      else
        flash[:danger] = "メインに指定している講座は削除できません"
        redirect_to banks_path
      end
    else
      flash[:danger] = "人の口座情報は変更できません"
      redirect_to workers_path
    end
  end

  private

  def bank_params
    params.require(:bank).permit(:worker_id, :bank_name, :store_number, :account_number, :is_default)
  end

  def only_worker!
    unless worker_signed_in?
      redirect_to root_path
    end
  end
end

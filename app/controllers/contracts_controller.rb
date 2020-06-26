class ContractsController < ApplicationController
  def index
    if worker_signed_in?
      @contracts = Contract.where(worker_id: current_worker.id)
    elsif employer_signed_in?
      @contracts = Contract.where(employer_id: current_employer.id)
    end
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def new
    @offer = Offer.find(params[:offer_id])
    @contract = Contract.new
  end

  def create
    @offer = Offer.find(params[:offer_id])
    @contract = current_worker.contracts.build(contract_params)
    if @offer.suggest.worker == current_worker
      @contract.employer_id = @offer.employer_id
      if @contract.save
        flash[:success] = "契約が完了しました。採用者からの連絡をお待ちください。"
        redirect_to worker_path(current_worker)
      else
        flash[:danger] = "契約できませんでした。運営にお問い合わせください。"
        redirect_to worker_path(current_worker)
      end
    else
      flash[:danger] = "自分宛にきたオファー以外は契約できません"
      redirect_to worker_path(current_worker)
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:worker_id, :employer_id, :price, :job_description, :target_date, :opening, :closing, :status)
  end
end

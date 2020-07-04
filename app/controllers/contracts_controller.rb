class ContractsController < ApplicationController
  before_action :only_worker!, only:[:new, :create]

  def index
    if worker_signed_in?
      contracts = Contract.where(worker_id: current_worker.id).order(target_date: :asc)
      @contracts = contracts.where.not(status: "契約終了")
      @end_contracts = contracts.where(status: "契約終了")
    elsif employer_signed_in?
      @contracts = Contract.where(employer_id: current_employer.id)
      @contracts = contracts.where.not(status: "契約終了")
      @end_contracts = contracts.where(status: "契約終了")
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
        redirect_to workers_path
      else
        flash[:danger] = "契約できませんでした。運営にお問い合わせください。"
        redirect_to workers_path
      end
    else
      flash[:danger] = "自分宛にきたオファー以外は契約できません"
      redirect_to workers_path
    end
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update(contract_params)
    redirect_to workers_path
  end

  private
  def contract_params
    params.require(:contract).permit(:worker_id, :employer_id, :price, :job_description, :target_date, :opening, :closing, :status)
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

class HoldsController < ApplicationController
  before_action :only_employer!

  def index
    @suggests = current_employer.hold_suggests.order(target_date: :asc)
    @target_dates = @suggests.group(:target_date).map{|date| date.target_date}
  end
  
  def create
    @suggest = Suggest.find(params[:suggest_id])
    @hold = current_employer.holds.build(suggest_id: @suggest.id)
    @hold.save
    flash.now[:success] = "案件を保留に追加しました。"
    render :toggle
  end

  def destroy
    @suggest = Suggest.find(params[:suggest_id])
    @hold = Hold.find(params[:id])
    @hold.destroy
    @hold = nil
    flash.now[:danger] = "保留中の案件から削除しました。"
    render :toggle
  end

  private
  def only_employer!
    unless employer_signed_in?
      redirect_to root_path
    end
  end

end

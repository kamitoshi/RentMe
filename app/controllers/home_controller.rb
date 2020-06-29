class HomeController < ApplicationController
  skip_before_action :login?
  before_action :signed_in_user?

  def top
  end

  def about
  end

  private
  def signed_in_user?
    if worker_signed_in?
      redirect_to workers_path
    elsif employer_signed_in?
      redirect_to employers_path
    end
  end
  
end

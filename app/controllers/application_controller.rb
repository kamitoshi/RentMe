class ApplicationController < ActionController::Base
  before_action :login?

  private
  def login?
    unless worker_signed_in? || employer_signed_in?
      redirect_to root_path
    end
  end
end

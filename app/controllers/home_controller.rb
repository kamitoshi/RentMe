class HomeController < ApplicationController
  skip_before_action :login?

  def top
  end

  def about
  end
end

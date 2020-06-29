class LocationsController < ApplicationController
  before_action :only_worker!

  def index
    @locations = current_worker.locations
    @location = Location.new
  end
  
  def create
    @location = current_worker.locations.build(location_params)
    if @location.save
      render :add_location
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    render :remove_location 
  end

  private
  def location_params
    params.require(:location).permit(:prefecture, :city, :place)
  end

  private
  def only_worker!
    unless worker_signed_in?
      redirect_to root_path
    end
  end

end

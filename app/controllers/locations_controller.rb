class LocationsController < ApplicationController
  
  def create
    @location = current_worker.locations.build(location_params)
    if @location.save
      render :add_location
    end
  end

  def destroy

  end

  private
  def location_params
    params.require(:location).permit(:prefecture, :city, :place)
  end

end

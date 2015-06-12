class LocationsController < ApplicationController
  before_action :set_location, :only=>[:edit,:update,:show,:destroy]
  before_action :authenticate_admin!, :except =>[:index,:show]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to locations_path
    else
      render :edit
    end
  end

  def index
   @locations = Location.all
  end

  def show
  end

  def edit
  end
 
  def update
    if @location.update(location_params)
      redirect_to locations_path
    else
      render :edit
    end
  end

  def destroy
   @location.destroy
     redirect_to locations_path
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit!
  end
end

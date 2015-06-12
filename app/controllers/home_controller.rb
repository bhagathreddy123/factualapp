#require 'factual'

class HomeController < ApplicationController
  def index
    #@results = Location.order(:name).page params[:page]
  #   @results = Location.order(:name)
  #    respond_to do |format|
  #   format.html
  #   format.xls # { send_data @results.to_csv(col_sep: "\t") }
  # end
   @results = Location.order(:name)
@hash = Gmaps4rails.build_markers(@results) do |result, marker|
  marker.lat result.latitude
  marker.lng result.longitude
end
  end
  
end


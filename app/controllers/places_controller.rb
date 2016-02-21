class PlacesController < ApplicationController
  def index
  end
  def show
  	@place = BeermappingApi.places_in(session[:searchString]).detect{|i| i.id == params[:id]}
  end

  def search
  	session[:searchString] = params[:city]
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    elsif @places == "no connection to database"  
      redirect_to places_path, notice: "No connection to database"
    else
      render :index
    end
  end
end
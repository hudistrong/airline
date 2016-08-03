class CitiesController < ApplicationController
  before_action :require_login
  def index
  	@cities = City.all
  end

  def update_is_open
    city = City.find(params[:city_id])
    city.update_attributes(:is_open => !city.is_open)
    @cities = City.all
    render :index
  end

end
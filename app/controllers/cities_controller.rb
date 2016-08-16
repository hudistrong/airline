class CitiesController < ApplicationController
  before_action :require_login
  def index
  	
  end

  def get_cities
    cities = City.all.order(:maturity)
    cities = cities.map do |c|
      c.attributes.merge({is_open_zh: c.is_open_zh, maturity_zh: c.maturity_zh, time: c.created_at.strftime("%Y-%m-%d %H:%M")})
    end
    respond_to do |format|
      format.json{render :json => {:success => true, :data => cities}}
    end
  end

  def update_is_open
    city = City.find(params[:city_id])
    city.update_attributes(:is_open => !city.is_open)
    @cities = City.all
    render :index
  end

end
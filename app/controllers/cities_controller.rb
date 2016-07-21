class CitiesController < ApplicationController
  before_action :require_login
  def index
  	@cities = City.all
  end

end
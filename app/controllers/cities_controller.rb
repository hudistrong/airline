class CitiesController < ApplicationController
  before_action :require_login
  def index
    puts self
    # image = MiniMagick::Image.open("http://www.imagewa.com/PhotoPreview/367/367_56025.jpg")
    # image.flip
    # image.write("app/assets/images/main_2.jpg")
    if $redis.get(:cities).present?
      @cities = JSON.parse($redis.get(:cities))
      @cities = @cities.collect do |city|
        City.new(city.deep_symbolize_keys)
      end
    else
      @cities = City.all.order("position asc")
      $redis.set(:cities, @cities.to_json)
    end
    # @cities = cities.map do |c|
    #   c.attributes.merge({is_open_zh: c.is_open_zh, maturity_zh: c.maturity_zh, time: c.created_at.strftime("%Y-%m-%d %H:%M")})
    # end
    # respond_to do |format|
    #   format.html
    #   format.json{render :json => {:success => true, :data => @cities}}
    # end
  end

  def get_cities

  end

  def update_is_open
    puts "******************"
    puts params.inspect
    city = City.find(params[:city_id])
    city.update_attributes(:is_open => !city.is_open)
    @cities = City.all
    render :index
  end

  def move_position
    city = City.find(params[:id])
    case params[:type]
      when 'pre'
        city.move_higher
      when 'next'
        city.move_lower
    end
    respond_to do |format|
      @cities = City.all.order("position asc")
      format.html {render :index}
    end
  end

end
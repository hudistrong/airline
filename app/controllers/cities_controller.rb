class CitiesController < ApplicationController
  before_action :require_login
  respond_to :html, :xls
  def index
    # image = MiniMagick::Image.open("http://www.imagewa.com/PhotoPreview/367/367_56025.jpg")
    # image.flip
    # image.write("app/assets/images/main_2.jpg")

      @cities = City.all.order("position asc")


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

  def upload_xls
    @user = User.new
  end

  def save_cities
    xls = Roo::Spreadsheet.open(params[:user][:xls_file])
    puts "==============>  #{xls.row(1)}"
    last_column = xls.last_column
    i,j,k = 0
    last_column.times do |index|
      if(xls.row(1)[index] == "创建时间")
        i = index
      end
      if(xls.row(1)[index] == "城市id")
        j = index
      end
      if(xls.row(1)[index] == "城市名")
        k = index
      end
    end
    xls.each do |x|
      unless x[i] == "创建时间"
        x[i] = Time.at(x[i])
        City.create({name: x[k], created_at: x[i], updated_at: x[i]})
      end
    end
    redirect_to cities_path
  end

end
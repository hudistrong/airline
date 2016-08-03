class CityAPI < Grape::API
  resources :cities do
    before do
      authenticate!
    end
    desc "获取城市列表"
    get :city_list do
      @cities = City.all

      present :data, @cities
    end
    
  end
end

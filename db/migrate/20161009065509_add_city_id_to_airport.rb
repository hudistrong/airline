class AddCityIdToAirport < ActiveRecord::Migration[5.0]
  def change
  	add_column :airports, :city_id, :integer
  end
end

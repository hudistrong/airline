class CreateCityAirCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :city_air_companies do |t|
      t.integer :city_id
      t.integer :air_company_id
      t.timestamps
    end

    add_index :city_air_companies, :city_id
    add_index :city_air_companies, :air_company_id
  end
end

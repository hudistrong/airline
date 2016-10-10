class CreateAirCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :air_companies do |t|
      t.string :name
      t.boolean :state
      t.string :air_code
      t.integer :country_id
      t.integer :level
      t.timestamps
    end
  end
end

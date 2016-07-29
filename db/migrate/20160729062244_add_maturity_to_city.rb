class AddMaturityToCity < ActiveRecord::Migration[5.0]
  def change
  	add_column :cities, :maturity, :integer
  end
end

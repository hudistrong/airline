class AddPositionToCities < ActiveRecord::Migration[5.0]
  def change
  	add_column :cities, :position, :integer
  end
end

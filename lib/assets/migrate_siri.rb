module Migrate_test
  class CreateSiris < ActiveRecord::Migration[5.0]
	 #    @city = City.where(id: @index).first
	 #    @tb_name = PinYin.of_string(@city)
		def self.migrate_test(&p)
  			@cities = City.all
  			@cities.each do |c|
	  			tb_name = p.call(c)
				create_table (tb_name[0]+tb_name[1]+'s').to_sym do |t|
					t.string :name
					t.string :level
					t.timestamps
				end
		    end
		end

		def self.delete_table
			@cities = City.all
			@cities.each do |c|
				tb_arr = PinYin.of_string(c.try(:name))
				# tb_name = (tb_arr[0]+tb_arr[1]+'s').to_sym
				# puts tb_name.class
				drop_table (tb_arr[0]+tb_arr[1]+'s').to_sym
			end
		end

		def self.create_tb name
			create_table name.to_sym do |t|
				t.string :name
				t.string :phone
				t.integer :price
			end
		end
	end
end



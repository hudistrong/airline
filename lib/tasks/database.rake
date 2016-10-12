require File.expand_path('../../assets/migrate_siri.rb', __FILE__)
require 'roo'
namespace :update_db do
	desc "数据库创建"
	task :create_database => :environment do 
    Migrate_test::CreateSiris.migrate_test do |city|
  	  @tb_name = PinYin.of_string(city.try(:name))
    end
	end
    desc "数据库删除"
	task :drop_table => :environment do
    Migrate_test::CreateSiris.delete_table
	end
  task :import_xls => :environment do
    xlsx = Roo::Spreadsheet.open('public/猜灯谜积分奖励明细.xlsx')
    Migrate_test::CreateSiris.create_tb('rewards')
    xlsx.each_with_pagename do |name, sheet|
    	sheet.each do |h|
    		puts h.inspect
    	end
    end
  end

end
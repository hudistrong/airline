class Airport < ApplicationRecord
	belongs_to :city

	enum level: %i(base normal qualified splendid)
    
    EN_ZH = {
	  	"base" => "1F",
	  	"normal" => "2F",
	  	"qualified" => "3F",
	  	"splendid" => "4F"
	}

	def level_zh 
	  EN_ZH[self.try(:level)]
	end
end

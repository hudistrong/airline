class City < ApplicationRecord
	enum maturity: %i(newarea half mature)
	acts_as_list :order => "position"

	def maturity_zh
		en_to_zh = {
			"newarea" => "新区",
			"half" => "半成熟区",
			"mature" => "成熟区"
	    }
	    en_to_zh[self.try(:maturity)]
	end

	def is_open_zh
		en_to_zh = {
			"false" => '否',
			"true" => '是'
		}
		en_to_zh[self.try(:is_open).to_s]
	end
	def is_ghost?
	end
end

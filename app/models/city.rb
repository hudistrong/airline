class City < ApplicationRecord
	enum maturity: %i(newarea half mature)

	def maturity_zh
		en_to_zh = {
			newarea: "新区",
			half: "半成熟区",
			mature: "成熟区"
	    }
	    en_to_zh[self.maturity.to_sym]
	end

	def is_open_zh
		en_to_zh = {
			false: '否',
			true: '是'
		}
		en_to_zh[self.is_open.to_s.to_sym]
	end
end

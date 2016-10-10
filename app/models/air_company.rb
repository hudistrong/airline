class AirCompany < ApplicationRecord
	has_many :city_air_companies
	has_many :cities, :through => :city_air_companies
end
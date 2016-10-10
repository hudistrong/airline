class CityAirCompany < ApplicationRecord
	belongs_to :city
	belongs_to :air_company
end
object @place

attributes :id, :title, :city, :street, :building, :apartment, :city_id

child :services => :service do
	extends "service/index"
end
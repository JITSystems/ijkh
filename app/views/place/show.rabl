object @place

attributes :id, :title, :city, :street, :building, :apartment

child :services => :service do
	extends "service/index"
end
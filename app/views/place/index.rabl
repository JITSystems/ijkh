collection @places

attributes :id, :title, :city, :street, :building, :apartment

child :services do
	extends "service/index"
end
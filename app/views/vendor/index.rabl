collection @vendors

attributes :id, :title, :inn

child :cities do
	extends 'city/index'
end
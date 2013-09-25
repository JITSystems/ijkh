collection @vendors

attributes :id, :title

child :cities do
	extends 'city/index'
end
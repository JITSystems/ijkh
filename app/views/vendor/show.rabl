object @vendor

attributes :id, :title, :merchant_id, :is_active, :inn

child :cities do
	extends 'city/index'
end
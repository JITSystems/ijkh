object @vendor

attributes :id, :title, :merchant_id, :is_active

child :cities do
	extends 'city/index'
end
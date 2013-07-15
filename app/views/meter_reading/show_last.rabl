object @meter_reading

attributes :id, :reading, :field_id, :created_at

node :reading do |o|
	FloatModifier.format(o.reading)
end

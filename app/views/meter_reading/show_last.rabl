object @meter_reading

attributes :id, :reading, :field_id, :created_at, :is_init

node :reading do |o|
	FloatModifier.format(o.reading)
end

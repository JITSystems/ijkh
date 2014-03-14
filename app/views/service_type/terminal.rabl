collection @service_types

attributes :id, :title

child :vendors do
	attributes :id, :title
	child :tariff_templates do
		attributes :id, :title
		child :field_templates do
			attributes :id, :title, :value, :field_units
		end
	end
end

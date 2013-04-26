module FieldsRepository
	def get_value field_id
		field = find(field_id)
		field.value
	end
end
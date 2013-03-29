module ServiceTypesRepository
	def ids
		select(:id).map(&:id)
	end

	def non_existant_service_types non_existant_service_type_ids
		where(id: non_existant_service_type_ids)
	end
end
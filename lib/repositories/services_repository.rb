module ServicesRepository

	def create_service service
		if new_service = Service.create!(service)
			new_service
		else
			nil
		end
	end
	
	def existant_service_type_ids place_id
  		where(place_id: place_id).uniq.select("service_type_id as id").map(&:id)
  	end

  	def by_user_and_place current_user, place_id 
  		where('place_id = ? and user_id = ?',place_id , current_user.id) 
  	end

  	
end
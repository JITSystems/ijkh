module ServicesRepository

	def destroy_with_dependencies service_id
		service = self.find(service_id)
		meter_readings = MeterReading.where(service_id: service_id)
		bills = Bill.where("place_id = ? and service_type_id = ? and status != 1", service.place_id, service.service_type_id) 
		if service.destroy
			meter_readings.each do |meter_reading|
				meter_reading.destroy
			end

			bills.each do |bill|
				bill.destroy
			end
			{status: "deleted"}
		else
			{error: "something went wrong"}
		end
	end

	def create_service user, params
		unless params[:service][:vendor].nil?
			create_predefined_service user, params
		else
			create_user_service user, params
		end
	end



	def existant_service_type_ids place_id
  		where(place_id: place_id).uniq.select("service_type_id as id").map(&:id)
  	end

  	def by_user_and_place current_user, place_id 
  		where('place_id = ? and user_id = ?',place_id , current_user.id) 
  	end

  	private

  	def create_predefined_service user, params
  		service_params = {
				title: 				params[:service][:title],
				place_id: 			params[:place_id],
				service_type_id: 	params[:service][:service_type_id],
				vendor_id: 			params[:service][:vendor][:id],
				user_account: 		params[:service][:user_account],
				user_id: 			current_user.id
			}

		service = Service.new(service_params)

		if service.save
			
		else
			
		end


  	end

  	def create_user_service user, params
  	end
  	
end
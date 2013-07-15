module MeterReadingsRepository
	
	def by_tariff tariff_id 
		where(tariff_id: tariff_id)
	end

	def save_snapshot user, snapshot, snapshot_name, service_id
		snapshot_name = snapshot_name.to_datetime
		name = snapshot_name.to_s(:number)+'.png'
		directory = File.join('public','images','meter_reading_snapshots', user.id.to_s, service_id.to_s)

		unless File.directory?(directory)
			FileUtils.mkdir_p(directory)
		end

		path = File.join(directory, name)
		File.open(path, "wb") { |f| f.write(snapshot.read) }
		directory = File.join('images','meter_reading_snapshots', user.id.to_s, service_id.to_s)
		path = File.join(directory, name)
		path
	end

	def new_meter_reading user, params
		meter_reading_params =  {
								 reading: FloatModifier.substitute_comma(params[:meter_reading][:reading]),
								 user_id: user.id,
								 is_init: false,
								 service_id: params[:service_id],
								 field_id: params[:meter_reading][:field_id]			
								}
		meter_reading = MeterReading.new(meter_reading_params)
		if meter_reading.save
			if params[:snapshot]
				snapshot_url = save_snapshot user, params[:snapshot], meter_reading.created_at.to_s, params[:service_id]
				meter_reading.update_attributes(snapshot_url: snapshot_url)
			end
			
			account_params = 
			{
				account: {
					user_id: user.id,
					service_id: params[:service_id],
					place_id: params[:place_id]
				},
				reading: params[:meter_reading][:reading],
				prev_reading: params[:prev_reading],
				service_id: params[:service_id],
				field_id: params[:meter_reading][:field_id]
			}
			account = Account.new_account account_params
			meter_reading
			
		else
			meter_reading = {error: "something went wrong"}
		end
	end
	
end
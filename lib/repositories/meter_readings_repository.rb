module MeterReadingsRepository
	
	def by_tariff tariff_id 
		where(tariff_id: tariff_id)
	end

	def save_snapshot user, snapshot, snapshot_name
		name = snapshot_name+'.png'
		directory = File.join('public','images','meter_reading_snapshots', user.id.to_s)

		unless File.directory?(directory)
			FileUtils.mkdir_p(directory)
		end

		path = File.join(directory, name)
		File.open(path, "wb") { |f| f.write(snapshot.read) }
		path
	end

	def new_meter_reading user, params
		meter_reading = MeterReading.new(params[:meter_reading].merge user_id: user.id, is_init: false)
		if meter_reading.save
			if params[:snapshot]
				snapshot_url = save_snapshot user, params[:snapshot], meter_reading.created_at.to_s
				meter_reading.update_attributes(snapshot_url: snapshot_url)
			end
			
			bill_params = 
			{
				bill: {
					user_id: user.id,
					service_id: params[:service_id],
					place_id: params[:place_id]
				},
				value_id: params[:meter_reading][:value_id],
				reading: params[:meter_reading][:reading],
				prev_reading: params[:prev_reading]
			}
			bill = Bill.new_bill bill_params
			meter_reading
		else
			meter_reading = {error: "something went wrong"}
		end
	end
	
end
module MeterReadingsRepository
	
	def by_tariff tariff_id 
		where(tariff_id: tariff_id)
	end

	def save_snapshot user, snapshot
		name = snapshot.original_filename
		directory = File.join('public','images','meter_reading_snapshots', user.id.to_s)
		path = File.join(directory, name)
		File.open(path, "wb") { |f| f.write(snapshot.read) }
		path
	end

	def new_meter_reading user, params
		if params[:snapshot]
			snapshot_url = save_snapshot user, params[:snapshot]
			params[:meter_reading].merge(snapshot_url: snapshot_url)
		end
		meter_reading = MeterReading.new(params[:meter_reading].merge user_id: user.id, is_init: false)
		if meter_reading.save
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
			meter_reading
			bill = Bill.new_bill bill_params
		else
			meter_reading = {error: "something went wrong"}
		end
	end
	
end
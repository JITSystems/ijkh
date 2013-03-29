class MeterReadingController < ApplicationController
	def index
		meter_readings = MeterReading.by_tariff(params[:tariff_id])
		render json: meter_readings
	end

	def create
		if params[:snapshot]
			name = params[:snapshot].original_filename
			directory = File.join('public','images','snapshot')
			path = File.join(directory, name)
			File.open(path, "wb") { |f| f.write(params[:snapshot].read) }
			params[:meter_reading].merge(snapshot_url: path)
		end

		meter_reading = MeterReading.new(params[:meter_reading].merge user_id: current_user.id)
		
		if meter_reading.save
			render json: meter_reading
		else
			render json: {error: "something went wrong"}
		end
	end

	def update
		meter_reading = MeterReading.find(params[:meter_reading_id])
		if meter_reading.update_attributes
			render json: meter_reading
		end
	end

	def destroy
		meter_reading = MeterReading.find(params[:meter_reading_id])
		if meter_reading.destroy
			render json: {status: "deleted"}
		end
	end


end
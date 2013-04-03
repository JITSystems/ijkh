class MeterReadingController < ApplicationController
	def index
		meter_readings = MeterReading.by_tariff(params[:tariff_id])
		render json: meter_readings
	end

	def create
		meter_reading = MeterReading.new_meter_reading current_user, params
		render json: meter_reading
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
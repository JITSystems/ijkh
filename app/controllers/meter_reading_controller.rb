class MeterReadingController < ApplicationController
	def index
		meter_readings = MeterReading.by_tariff(params[:tariff_id])
		render 'meter_reading/index'
	end

	def create
		meter_reading = MeterReading.new_meter_reading current_user, params
		render 'meter_reading/show'
	end

	def show_last
		@meter_reading = MeterReading.where(field_id: params[:field_id]).order("created_at DESC").limit(1)
		render 'meter_reading/show_last'
	end


end
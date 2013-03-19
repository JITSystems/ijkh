class MeterReadingController < ApplicationController
	def index
		@meter_readings = MeterReading.select("id, reading").where(tariff_id: params[:tariff_id])
		render json: @meter_readings
	end

	def create
		@user = User.select(:id).where(authentication_auth: params[:auth_token]).first
		@meter_reading = MeterReading.new(params[:meter_reading].merge user_id: @user.id)
		if @meter_reading.save
			render json: {meter_reading: @meter_reading.as_json(only: [:id, :reading])}
		else
			render json: {error: "something went wrong"}
		end
	end

	def update
		@meter_reading = MeterReading.find(params[:meter_reading_id])
		if @meter_reading.update_attributes
			render json: {meter_reading: @meter_reading}
		end
	end

	def destroy
		@meter_reading = MeterReading.find(params[:meter_reading_id])
		if @meter_reading.destroy
			render json: {status: "deleted"}
		end
	end


end
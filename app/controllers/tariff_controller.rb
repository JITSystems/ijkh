class TariffController < ApplicationController
	def index
		# GET api/1.0/service/:service_id/tariff	
		render 'tariff/index'
	end
end
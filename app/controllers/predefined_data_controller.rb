class PredefinedDataController < ApplicationController
	def index
		render json: {api: "1.0"} #dummy
	end
end

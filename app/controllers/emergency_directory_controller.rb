class EmergencyDirectoryController < ApplicationController
	def index
		@emergency_districts = EmergencyDistrict.all

		render 'emergency_directory/index'
	end
end
class EmergencyDirectoryController < ApplicationController
	def index
		@emergency_districts = EmergencyDistrictManager.index

		render 'emergency_directory/index'
	end
end
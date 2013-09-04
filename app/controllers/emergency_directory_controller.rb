class EmergencyDirectoryController < ApplicationController
	def index
		@district = EmergencyDistrict.all
		
		render 'emergency_directory/index'
	end
end
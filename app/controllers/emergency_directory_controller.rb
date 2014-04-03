class EmergencyDirectoryController < ApplicationController
	def index
		# GET api/1.0/emergency_directory
		@emergency_categories = EmergencyCategoryManager.index
		render 'emergency_directory/index'
    
	end
end
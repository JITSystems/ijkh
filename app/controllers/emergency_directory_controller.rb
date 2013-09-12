class EmergencyDirectoryController < ApplicationController
	def index
		@emergency_categories = EmergencyCategoryManager.index

		render 'emergency_directory/index'
	end
end
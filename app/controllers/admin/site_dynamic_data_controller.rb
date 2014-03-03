class Admin::SiteDynamicDataController < AdminController
	def index
		@sdd = SiteDynamicData.first
		render :index
	end

	def edit
		@sdd = SiteDynamicData.first
		render :edit
	end

	def update
		SiteDynamicData.first.update_attributes(params[:site_dynamic_data])
		redirect_to admin_site_dynamic_data_path
	end
end
class WebInterface::CompanyController < WebInterfaceController
	layout 'title_page'
	skip_before_filter :require_current_user

	before_filter :get_statistics

	def get_statistics
		@users = User.all.count
    	@vendors = Vendor.where(is_active: true).count
	end

	def ijkh
	end

	def ad_on_site
	end

	def show
	end

	def about
	end

	def partners
	end

	def investors
	end

	def contacts
	end

	def details
	end

end

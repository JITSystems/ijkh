class WebInterface::CompanyController < WebInterfaceController
	layout 'title_page'
	skip_before_filter :require_current_user

	before_filter :get_statistics

	def get_statistics
		@users = User.all.count
    	@vendors = Vendor.where(is_active: true).count
	end

	def show
	end


	def ijkh
		# get 'title_ijkh' => 'web_interface/company#ijkh'
	end

	def ad_on_site
		# get 'title_ad_on_site' => 'web_interface/company#ad_on_site'
	end

	def about
		# get 'title_about' => 'web_interface/company#about'
	end

	def partners
		# get 'title_partners' => 'web_interface/company#partners'
	end

	def investors
		# get 'title_investors' => 'web_interface/company#investors'
	end

	def contacts
		# get 'title_contacts' => 'web_interface/company#contacts'
	end

	def details
		# get 'title_details' => 'web_interface/company#details'
	end

	def freelancer
		# get "title_freelancer/:freelancer_id" => "web_interface/company#freelancer"

		@freelancer = Freelancer.find(freelancer_id = params[:freelancer_id])
	end

end

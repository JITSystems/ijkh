class WebInterface::FreelancersController < WebInterfaceController
	skip_before_filter :require_current_user
  def show
  	# get "freelancers" => "web_interface/freelancers#show"
		@freelance_category = FreelanceCategory.order('title asc')
    	@freelancer = Freelancer.order('title asc')
  end

  def pay
  	# get "freelance_payment" => "web_interface/freelancers#pay"
  		
  end
end

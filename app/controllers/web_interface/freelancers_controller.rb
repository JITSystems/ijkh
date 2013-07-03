class WebInterface::FreelancersController < WebInterfaceController
	skip_before_filter :authenticate_user!
  def show
		@freelance_category = FreelanceCategory.order('title asc')
    	@freelancer = Freelancer.order('title asc')
  end
end

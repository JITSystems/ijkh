# encoding: utf-8

class WebInterface::FreelancerModerationController < WebInterfaceController
	# skip_before_filter :require_current_user
  def show
 	if current_user.email == "john.loudless@gmail.com"
 		@freelance_category = FreelanceCategory.order('created_at')
    	@freelancer = Freelancer.order('created_at desc')
    else
    	@freelance_category = []
    	@freelancer = []
 	end
    	
  end

  def update
  	# @message = "Услуга опубликована."
  	@freelancer = Freelancer.find(params[:id])
  	@freelancer.update_attribute(published: params[:published])
  end

  def destroy
  	@message = "Услуга удалена."
  	@freelancer = Freelancer.find(params[:id])
  	@freelancer.destroy
  end

  def publish_all_freelancers
  	@message = "Все частные услуги опубликованы."
  	Freelancer.update_all(published: true)
  end

end

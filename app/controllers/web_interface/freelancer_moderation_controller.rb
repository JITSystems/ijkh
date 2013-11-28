# encoding: utf-8

class WebInterface::FreelancerModerationController < WebInterfaceController
	# skip_before_filter :require_current_user

  http_basic_authenticate_with name: "root", password: "password", :except => :show

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
    @published = params[:published]
  	@freelancer = Freelancer.find(params[:id])
  	@freelancer.update_attributes(published: @published)

    case @published
    when 'true'
      @message = "Услуга опубликована."
    when 'false'
      @message = "Услуга снята с публикации."
    end

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

# encoding: utf-8

class WebInterface::FreelancerRegistrationController < WebInterfaceController
	# skip_before_filter :require_current_user
  def show
    # get "freelancer_registration" => "web_interface/freelancer_registration#show"

  		@freelance_category = []

  		FreelanceCategory.order('title asc').each do |f_c|
  			@freelance_category << [f_c.title, f_c.id, {listType: 'freelance_category'}]	
  		end 
		
    	@freelancer = Freelancer.new
  end

  
  def create

    # post "freelancer_registration" => "web_interface/freelancer_registration#create"
  	
    @freelancer = Freelancer.new(params[:freelancer].merge!(published: false))

  	if @freelancer.save
			redirect_to action: :show, id: @freelancer.id
		else 
			render 'show'
		end

  end


end

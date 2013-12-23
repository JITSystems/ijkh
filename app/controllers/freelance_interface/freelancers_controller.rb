class FreelanceInterface::FreelancersController < FreelanceInterfaceController

	def show
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
	end

	
	def new
		@freelancer = FreelanceInterface::Freelancer.new
	end

	
	def create
		@freelancer = FreelanceInterface::Freelancer.new(params[:freelancer])

		if @freelancer.save
			#redirect_to action: :show, id: @freelancer.id
			redirect_to @freelancer
		else 
			render 'new'
		end
	end

	
	def edit
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])
	end


	def update
	  @freelancer = FreelanceInterface::Freelancer.find(params[:id])
	 
	  if @freelancer.update_attributes(params[:post])
	    redirect_to :action => :show, id: @freelancer.id
	  else
	    render 'edit'
	  end
	end

	def index

		@freelancers = FreelanceInterface::Freelancer.all
	end


	def destroy
		@freelancer = FreelanceInterface::Freelancer.find(params[:id])

		@freelancer.destroy

		redirect_to action: :index
	end
	

end
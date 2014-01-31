class FreelanceInterface::TagsController < FreelanceInterfaceController

	def show
		@tag = FreelanceInterface::Tag.find(params[:id])
		@freelancers = @tag.freelancers
	end


	def update
		
	end 
end
class FreelanceInterface::TagsController < FreelanceInterfaceController

	def show
		@tag = FreelanceInterface::Tag.find(params[:id])
		@freelancers = @tag.freelancers
	end


	def update
		@tag = FreelanceInterface::Tag.find(params[:id])
	 
	  	if @tag.update_attributes(params[:tag])
	    	render json: @tag.to_json
	  	else
		    render status: 500
		end
		# render json: params.to_json
	end 
end
class FreelanceInterface::TagsController < FreelanceInterfaceController

	def show
		@tag = FreelanceInterface::Tag.find(params[:id])
		@freelancers = @tag.freelancers
	end


	def update
		render json: params.to_json
	end 
end
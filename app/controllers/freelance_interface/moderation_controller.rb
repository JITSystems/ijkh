class FreelanceInterface::ModerationController < FreelanceInterfaceController

	def show
		@freelancers = FreelanceInterface::Freelancer.where(published: false)
		@tags = FreelanceInterface::Tag.where(published: false)
		@comments = FreelanceInterface::Comment.where(published: false)
	end

	def update
		render json: params.to_json		
	end
end
class FreelanceInterface::ModerationController < FreelanceInterfaceController

	def show
		@freelancers = FreelanceInterface::Freelancer.where(published: false)
		@tags = FreelanceInterface::Tag.where(published: false)
		@comments = FreelanceInterface::Comment.where(published: false)
	end

	def update
	
	end
	
	def update_freelancers
		render json: params.to_json		
	end
	
	def update_comments
		render json: params.to_json		
	end
	
	def update_tags
		render json: params.to_json	
	end
end
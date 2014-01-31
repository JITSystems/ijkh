# encoding: utf-8

class FreelanceInterface::ModerationController < FreelanceInterfaceController

	def show
		@freelancers = FreelanceInterface::Freelancer.where(published: false)
		@tags = FreelanceInterface::Tag.where(published: false)
		@comments = FreelanceInterface::Comment.where(published: false)
	end

	def update
	
	end
	
	def update_freelancers
		freelancer = FreelanceInterface::Freelancer.find(params[:id])
		published = params[:published]


		case published
			when 'false'
				@message = "Снято с публикации"
			when 'true'
				@message = "Опубликовано"
		end

		unless freelancer.update_attributes!(published: published)
			@message = "Что-то пошло не так"
		end

		respond_to do |format|
			format.js {
				render 'result'
			}
		end
	end
	
	def update_comments
		comment = FreelanceInterface::Comment.find(params[:id])
		render json: params.to_json		
	end
	
	def update_tags
		tag = FreelanceInterface::Tag.find(params[:id])
		render json: params.to_json	
	end
end
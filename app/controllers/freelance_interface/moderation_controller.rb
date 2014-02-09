# encoding: utf-8

class FreelanceInterface::ModerationController < FreelanceInterfaceController

	def show
		# get 'fi_moderation' => 'freelance_interface/moderation#show'

		@freelancers = FreelanceInterface::Freelancer.where(published: false)
		@tags = FreelanceInterface::Tag.where(published: false)
		@comments = FreelanceInterface::Comment.where(published: false)
	end

	def reject
		# get 'fi_moderation/reject' => 'freelance_interface/moderation#reject'
		
		@user = User.where(id: params[:fi_reject_user_id]).first
		@message = params[:fi_reject_message]

		logger.info params


		FiModerationMailer.reject(@user, @message).deliver

		render js:  "clearForm();"
	end

end
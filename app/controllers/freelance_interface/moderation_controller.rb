# encoding: utf-8

class FreelanceInterface::ModerationController < FreelanceInterfaceController

	def show
		@freelancers = FreelanceInterface::Freelancer.where(published: false)
		@tags = FreelanceInterface::Tag.where(published: false)
		@comments = FreelanceInterface::Comment.where(published: false)
	end

	def reject
		@user = User.where(id: params[:user_id]).first

		FiModerationMailer.reject(@user).deliver

		render js:  "alert('Отправлено!');"
	end

end
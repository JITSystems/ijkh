class WebInterface::PaymentController < WebInterfaceController
	def show
		@places = Place.where("user_id = ? and is_active = true", current_user.id)
	end
end
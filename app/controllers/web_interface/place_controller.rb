class WebInterface::PlaceController < WebInterfaceController
	def index

	end

	def create
		@place = Place.new(params[:place].merge!(user_id: current_user.id, is_active: true))
		if @place.save
			respond_to do |format|
				format.js {
					render 'web_interface/place/create'
				}
			end
		end
	end
end
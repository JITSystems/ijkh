class WebInterface::PlaceController < WebInterfaceController
	def index

	end

	def get_place
		@place = Place.find(params[:place_id])
		respond_to do |format|
			format.js {
				render 'web_interface/place/place_card'
			}
		end
	end

	def create
		@place = Place.new(params[:place].merge!(user_id: current_user.id, is_active: true))
		if @place.save
			if params[:controller] == "registrations"
				respond_to do |format|
					format.js {
						render 'web_interface/place/create'
					}
				end
			else
				respond_to do |format|
					format.js {
						render 'web_interface/place/create_profile'
					}
				end
			end
		end
	end
end
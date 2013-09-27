# encoding: utf-8 

class WebInterface::PlaceController < WebInterfaceController
	def index

	end

	def destroy
		@place = Place.find(params[:place_id])
		@place_to_destroy = Place.deactivate @place
		respond_to do |format|
			format.js {
				render 'web_interface/place/delete'
			}
		end
	end

	def get_place
		@place = Place.find(params[:place_id])
		@vendors = Vendor.select("id, title, service_type_id").all
		@service_types = ServiceType.select("id, title").all
		@tariffs = Tariff.select("id, title").all
		respond_to do |format|
			format.js {
				render 'web_interface/place/place_card'
			}
		end
	end

	def deactivate
		@message = "Объект успешно удалён."
		@place = Place.find(params[:id])
		if @place.update_attribute('is_active', false)
			respond_to do |format|
				format.js {render "web_interface/place/deactivate"}
			end
		else 
			# place errors messages here
		end
	end

	def update 
		@message = "Данные об объекте успешно изменены."
		@place = Place.find(params[:id])

		if @place.update_attributes(params[:place])
			respond_to do |format|
				format.js {render "web_interface/place/update"}
			end
		else
			@message = "Пожалуйста, заполните информацию об объекте."
			respond_to do |format|
				format.js {render "web_interface/place/error"}
			end
		end
	end 

	def profile_create
		@message = "Объект успешно создан!"
		@place = Place.new(params[:place].merge!(user_id: current_user.id, is_active: true))
		
		if @place.save
			respond_to do |format|
				format.js {
					render 'web_interface/place/create_profile'
				}
			end
		end
	end

	def create
		@message = "Объект успешно создан."
		@place = Place.new(params[:place].merge!(user_id: current_user.id, is_active: true))
		#@place = PlaceManager.create(params[:place], current_user)
		if @place.save		
			respond_to do |format|
				format.js {
					render 'web_interface/place/create'
				}
			end
		else
			@message = "Пожалуйста, заполните информацию об объекте."
			respond_to do |format|
				format.js {
					render 'web_interface/place/error'
				}
			end
		end
	end
end



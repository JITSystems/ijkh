class PlaceManager < ObjectManager

	def self.create(params, user)
		city_id = CityManager.get_by_title(params[:city])
		place = Place.create!(params.merge!(user_id: user.id, is_active: true, city_id: city_id))
		place
	end

	def self.deactivate(place)
		# Updates is_active attribute of given place to false, returns place

		if place.update_attributes(is_active: false)
			place
		else
			# Implement error class
		end
	end

	def self.index_by_user(user)
		# Finds and returns all places that belong to given user
		places = user.places.where(is_active: true)
	end

	def self.index_with_data_by_user(user)
		# Finds all places that belong to given user and returns 
		# it with all related data
	end

	def self.update(params, place_id)
		# Updates attributes for given place. Checks if 'city' attribute changes
		# and updates 'city_id' if true
		place = Place.find(place_id)
		if params and params[:city]
			city_id = CityManager.get_by_title(params[:city])
			params.merge!(city_id: city_id)
		end
		place.update_attributes(params)
		place
	end

	def self.city_id_match
		places = PlaceManager.index
	    places.each do |place|
	      city = City.where(title: place[:city].capitalize).first
	      if city
	        place.update_attribute(:city_id, city.id)
	      else
	        place.update_attribute(:city_id, 0)
	      end
	    end
	    places
	end

end
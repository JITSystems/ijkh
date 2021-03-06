class CityManager < ObjectManager
	def self.get_by_title(title)
		city_id = City.where(title: title.to_s.capitalize).pluck(:id).first
		city_id
	end
end
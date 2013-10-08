# encoding: utf-8 

class PrecinctManager < ObjectManager

	def self.fetch_precinct(street_id, house)
		@precinct = {}
		@street = PrecinctStreet.find(street_id.to_i)
		if @street
			@house = PrecinctHouse.where("house = ? and precinct_street_id = ?", house, @street.id).first
			if @house
				@precinct = Precinct.find(@house.precinct_id)
			end
		end
		# @precinct = PrecinctStreet.find(street_id).precinct_houses.where(house: house).first.precinct
		@precinct
	end

	def self.search_by_id(p_id)
		@precinct = Precinct.find(p_id)
		@precinct		
	end

	def self.search_by_name(search_request)
		@precincts = Precinct.where("lower(name) like '#{search_request}%' or lower(surname) like '#{search_request}%' or lower(middlename) like '#{search_request}%'")
		@precincts
	end

	def self.search_by_street(search_request)
		@streets = PrecinctStreet.where("lower(street) like '#{search_request}%'")
		@streets
	end

end
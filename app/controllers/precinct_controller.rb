# encoding: utf-8 
class PrecinctController < ApplicationController
	
	def fetch_precinct
		@precinct = {}
		@street = PrecinctStreet.find(params[:street_id].to_i)
		logger.info @street.inspect
		if @street
			@house = PrecinctHouse.where("house = ? and precinct_street_id = ?", params[:house], @street.id).first
			logger.info @house.inspect
			if @house
				@precinct = Precinct.find(@house.precinct_id)
				logger.info @precinct.inspect
			end
		end
		render 'precinct/show'
	end

	def search_by_name
		search_request = params[:search_request]
		@precincts = Precinct.where("lower(name) like '#{search_request}%' or lower(surname) like '#{search_request}%' or lower(middlename) like '#{search_request}%'")
		render 'precinct/index'
	end

	def search_by_street
		search_request = params[:search_request]
		@streets = PrecinctStreet.where("lower(street) like '#{search_request}%'")
		render json: {streets: @streets}
	end

	def parse_precinct
		Ovd.xls_parser
		render json: {status: "success"}
	end
end
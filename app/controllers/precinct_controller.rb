# encoding: utf-8 
class PrecinctController < ApplicationController
	
	def fetch_precinct
		# GET api/1.0/precinct/fetch
		@precinct = PrecinctManager.fetch_precinct(params[:street_id], params[:house])
		render 'precinct/show'
	end

	def search_by_name
		# GET api/1.0/precinct/search_by_name
		@precincts = PrecinctManager.search_by_name(params[:search_request])
		render 'precinct/index'
	end

	def search_by_street
		# GET api/1.0/precinct/search_by_street
		@streets = PrecinctManager.search_by_street(params[:search_request])
		render json: {streets: @streets}
	end

	def parse_precinct
		# GET api/1.0/precinct/create
		Ovd.xls_parser
		render json: {status: "success"}
	end
end
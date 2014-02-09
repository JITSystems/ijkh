# encoding: utf-8 
class WebInterface::PrecinctController < WebInterfaceController
	
	skip_before_filter :require_current_user


	def show
		#  get  'precinct' => 'web_interface/precinct#show'
		# @precincts = Precinct.new
	end

	def search_by_name 
		# post 'precinct_by_name' => 'web_interface/precinct#search_by_name'

		@precincts = PrecinctManager.search_by_name(params[:search_request])
		# render json: @precincts
		respond_to do |format|
			format.js {
				render 'web_interface/precinct/search_by_name'
			}
		end

	end

	def search_by_id 
		# post 'precinct_by_id' => 'web_interface/precinct#search_by_id'

		@precinct = PrecinctManager.search_by_id(params[:search_request])
		# render json: @precinct
		respond_to do |format|
			format.js {
				render 'web_interface/precinct/search_by_id'
			}
		end
		
	end
	
	def search_by_street
		# post 'precinct_by_street' => 'web_interface/precinct#search_by_street'

		@streets = PrecinctManager.search_by_street(params[:search_request])
		# render json: @streets
		respond_to do |format|
			format.js {
				render 'web_interface/precinct/search_by_street'
			}
		end

	end

	def fetch_precinct
		# post 'fetch_precinct' => 'web_interface/precinct#fetch_precinct'

		@precinct = PrecinctManager.fetch_precinct(params[:street_id], params[:house])
		# render json: @precinct
		respond_to do |format|
			format.js {
				render 'web_interface/precinct/search_by_id'
			}
		end
		
	end

end
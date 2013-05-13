class PlaceAnalytic
	attr_accessor :title, :amount, :place_id, :service_analytic
	
	def initialize params
		@place_id = params[:place_id]
		@title = get_place_title params[:place_id]
		@service_analytic = generate_service_analytic params[:place_id], params[:month]
		@amount = calculate_amount @service_analytic
	end

	def self.get_by_user_and_month user, month
		place_ids = Place.where(user_id: user.id).select(:id).map(&:id)
		place_analytics = []
		place_ids.each do |place_id|
			
			place_analytic_params = {
				place_id: 	place_id,
				month: 		month
			}

			place_analytic = PlaceAnalytic.new(place_analytic_params)
			unless place_analytic.service_analytic == []
				place_analytics << place_analytic
			end
		end
		place_analytics
	end

	private

	def get_place_title place_id
		place = Place.find(place_id)
		place.title
	end

	def generate_service_analytic place_id, month
		service_account = ServiceAnalytic.get_by_place_id place_id, month
		service_account
	end

	def calculate_amount service_analytic
		amount = 0.0
		service_analytic.each do |analytic|
			amount += analytic.amount.to_f
		end
		amount
	end

end
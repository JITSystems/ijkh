class PlaceAccount

	attr_accessor :title, :service_account, :amount, :place_id

	def initialize params={}
		@service_account = generate_service_account params[:place_id], params[:status]
		@title = get_place_title params[:place_id]
		@amount = calculate_amount @service_account
		@place_id = params[:place_id]
	end

	def self.get_by_user_id user_id, status
		place_ids = Place.where("user_id = ? and is_active = true ",user_id).select(:id).map(&:id)
		place_accounts = []
		place_ids.each do |place_id|
			place_account_params = {
				place_id: place_id,
				status: status
			}
			
			place_account = PlaceAccount.new(place_account_params)
			place_accounts << place_account
		end
		place_accounts
	end

	private

	def get_place_title place_id
		place = Place.find(place_id)
		place.title
	end

	def generate_service_account place_id, status
		service_account = ServiceAccount.get_by_place_id place_id, status
		service_account
	end

	def calculate_amount service_account
		amount = 0.0
		service_account.each do |account|
			amount += account.amount.to_f
		end
		amount
	end
end
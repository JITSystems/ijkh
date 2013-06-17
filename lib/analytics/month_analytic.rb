class MonthAnalytic
	attr_accessor :month, :amount, :place_analytic
	# month, amount

	def initialize user, params
		@month = params[:month]
		@place_analytic = generate_place_analytic user, @month
		@amount = calculate_amount @place_analytic
	end

	def self.get_annual user
		month_array = [1,2,3,4,5,6,7,8,9,10,11,12]
		month_analytics = []

		month_array.each do |month|
			month_analytic_params = {
				month: month
			}
			month_analytic = MonthAnalytic.new(user, month_analytic_params)
			unless month_analytic.place_analytic == []
				month_analytics << month_analytic
			end
		end
		month_analytics
	end

	private

	def calculate_amount place_analytic
		amount = 0.0
		place_analytic.each do |analytic|
			if analytic.amount
				amount += analytic.amount 
			end
		end
		return amount.round(2)
	end

	def generate_place_analytic user, month
		place_analytic = PlaceAnalytic.get_by_user_and_month user, month
		place_analytic
	end
end
class ReportDataManager
	def initialize(from, to)
		@from = from
		@to = to
	end

	def index
		payment_histories = PaymentHistory.where("status = 1 AND payment_type = '1' AND po_date_time >= ? AND po_date_time < ? AND service_id is not null", @from, @to)
			.includes(:service)
				.map do |ph| 
					{
						amount: ph.amount, 
						date: ph.po_date_time, 
						address: "#{ph.service.place.city}, #{ph.service.place.street}, #{ph.service.place.building}, #{ph.service.place.apartment}", 
						vendor_id: ph.service.vendor_id, 
						user_account: ph.service.user_account
					} if ph.service
				end
		payment_histories
	end

	def self.index_by_vendor(vendor_id, month)
		payment_histories = PaymentHistory.where("extract(month from created_at) = ?", month)
			.includes(:service)
			.map do |ph|
				{
					amount: ph.amount,
					date: ph.po_date_time,
					address: "#{ph.service.place.city}, #{ph.service.place.street}, #{ph.service.place.building}, #{ph.service.place.apartment}",
					vendor_id: vendor_id,
					user_account: ph.service.user_account
				} if ph.service && ph.service.vendor_id == vendor_id
			end
			.reject {|ph| !ph}
		payment_histories
	end

	def self.vendors_with_transactions(month)
		vendor_ids = PaymentHistory.where("status = 1 AND payment_type = '1' AND extract(month from po_date_time) = ? and service_id is not null", month)
			.includes(:service)
			.map {|ph| ph.service.vendor_id if ph.service && ph.service.vendor}
			.reject {|ph| !ph}
			.uniq
	end
end
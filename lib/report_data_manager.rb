class ReportDataManager
	def initialize(from, to)
		@from = from
		@to = to
	end

	def index
		payment_histories = PaymentHistory.where("status = 1 AND payment_type = '1' AND po_date_time >= ? AND po_date_time < ? AND service_id is not null", @from, @to)
			.includes(:service)
				.map do |ph| 
					if ph.service
						if ph.service.vendor_id == 16
							tariff_template_id = ph.service.tariff.tariff_template_id
							case tariff_template_id.to_i
							when 157
								user_account =  "1##{ph.service.user_account}"
							when 155
								user_account = "2##{ph.service.user_account}"
							when 156
								user_account = "3##{ph.service.user_account}"
							else
								user_account = "#{ph.service.user_account}"
							end
						else
							user_account = ph.service.user_account
						end
						{
							amount: ph.amount, 
							date: ph.po_date_time, 
							address: "#{ph.service.place.city}, #{ph.service.place.street}, #{ph.service.place.building}, #{ph.service.place.apartment}", 
							vendor_id: ph.service.vendor_id, 
							user_account: user_account
						}
					end
				end
				.reject {|ph| !ph}
		payment_histories
	end

	def self.index_by_vendor(vendor_id, month)
		payment_histories = PaymentHistory.where("status = 1 AND payment_type = '1' AND extract(month from created_at) = ?", month.to_i)
			.includes(:service)
			.map do |ph|
				{
					amount: ph.amount,
					date: ph.po_date_time,
					address: "#{ph.service.place.city}, #{ph.service.place.street}, #{ph.service.place.building}, #{ph.service.place.apartment}",
					vendor_id: vendor_id.to_i,
					user_account: ph.service.user_account
				} if ph.service && ph.service.vendor_id.to_i == vendor_id.to_i
			end
			.reject {|ph| !ph}
		payment_histories
	end

	def self.vendors_with_transactions(month)
		vendor_ids = PaymentHistory.where("status = 1 AND payment_type = '1' AND extract(month from po_date_time) = ? and service_id is not null", month.to_i)
			.includes(:service)
			.map {|ph| ph.service.vendor_id if ph.service && ph.service.vendor}
			.reject {|ph| !ph}
			.uniq
	end
end
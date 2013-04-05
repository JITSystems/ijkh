# encoding: utf-8 
module BillsRepository

	def pay_bill user, amount, order_id
		sk_str ='MerchantId=39859&OrderId='+order_id.to_s+'&Amount='+amount.to_s+'&Currency=RUB&PrivateSecurityKey=7ab9d14e-fb6b-4c78-88c2-002174a8cd88'
		sk = Digest::MD5.hexdigest(sk_str)
		url = "https://secure.payonlinesystem.com/ru/payment/select?MerchantId=39859&OrderId=#{order_id}&Amount=#{amount}&Currency=RUB&SecurityKey=#{sk}"
	end

	def index_month_bill user, status
		month_bill = []
		months = 1..Date.today.month
		months.each do |month|
			sum_month = sum_up_month(user, month, status)
			month_bill << sum_month unless sum_month.blank?
		end
		{month_bill: month_bill}
	end

	def new_bill params
		place_title = Place.find(params[:bill][:place_id])
		service_type = ServiceType.find(params[:bill][:service_type_id])
		service = Service.find(params[:service_id])
		vendor = Vendor.find(service.vendor_id)
		tariff = Tariff.find(service.tariff_id)

		value = Value.by_id(params[:value_id])
		value = value.value
		reading = params[:reading]
		prev_reading = params[:prev_reading]
		amount = (reading.to_f-prev_reading.to_f)*value.to_f
		bill = Bill.new(params[:bill].merge(amount: amount, status: '-1', place_title: place_title.title, service_type_title: service_type.title, tariff_title: tariff.title, vendor_title: vendor.title))
		bill.save
	end

	def index_detailed_bills user, params
		bills = Bill.where("extract(month from created_at) = ? and user_id = ? and service_type_id = ? and place_id = ?", params[:month], user.id, params[:service_type_id], params[:place_id]).select("amount, vendor_title, tariff_title, created_at")
	end

private
	def sum_up_month user, month, status
		place_bill = []
		month_bill = where("extract(month from created_at) = ? and user_id = ? and status #{status}", month, user.id).select("extract(month from created_at) as month, sum(cast(amount as float)) as amount").group("created_at").first
		if month_bill
			places = Bill.where("extract(month from created_at) = ? and user_id = ? and  status #{status}", month, user.id).uniq.select(:place_id).map(&:place_id)
			places.each do |place|
				sum_place = sum_up_place(user, month, place, status)
				place_bill << sum_place
			end
		month_bill[:place_bill] = place_bill
		month_bill
	end
		
	end

	def sum_up_place user, month, place_id, status
		service_type_bill = []
		place_bill = where("extract(month from created_at) = ? and user_id = ? and place_id = ? and status #{status}", month, user.id, place_id).select("sum(cast(amount as float)) as amount, place_id, place_title").group("place_id, place_title").first
		if place_bill
			service_types = Bill.where("extract(month from created_at) = ? and user_id = ? and place_id = ? and status #{status}", month, user.id, place_id).uniq.select(:service_type_id).map(&:service_type_id)
			service_types.each do |service_type|
				sum_service_type = sum_up_service_type user, month, place_id, service_type, status
				service_type_bill << sum_service_type
			end
			place_bill[:service_type_bill] = service_type_bill
			place_bill
		end
	end

	def sum_up_service_type user, month, place_id, service_type_id, status
		service_type_bill = where("extract(month from created_at) = ? and user_id = ? and place_id = ? and service_type_id = ? and status #{status}", month, user.id, place_id, service_type_id).select("sum(cast(amount as float)) as amount, service_type_id, service_type_title, status, max(created_at) as last_update_date").group("service_type_id, status, service_type_title").first
	end
end
class ReportDataController < ApplicationController
	def index_daily
		payload = []
		payment_histories = PaymentHistory.where("status = 1 AND payment_type = '1' AND po_date_time >= ? AND po_date_time < ?", Date.yesterday, Date.today)
		payment_histories.each do |p_h|
			recipe = Recipe.find(p_h.recipe_id)
			amount = recipe.total
				service = recipe.service
			if service
				place = service.place
				if service.vendor
					vendor_id = service.vendor.id
					date = p_h.po_date_time
					address = "#{place.city}, #{place.street}, #{place.building}, #{place.apartment}"
					user_account = service.user_account
					payload << {user_account: user_account, address: address, amount: amount, date: date, vendor_id: vendor_id}
				end
			end
		end
		render json: {payload: payload}
	end

	def index_monthly_by_vendor
		payload = []
		month = params[:month]
		fetch_vendor_id = params[:vendor_id]
		payment_histories = PaymentHistory.where("extract(month from created_at) = ?", month)
		payment_histories.each do |p_h|
			recipe = Recipe.find(p_h.recipe_id)
			date = p_h.po_date_time
			if recipe
				amount = recipe.total
				service = recipe.service
				if service
					place = service.place
					if service.vendor
						vendor_id = service.vendor.id
						address = "#{place.city}, #{place.street}, #{place.building}, #{place.apartment}"
						user_account = service.user_account
						if vendor_id.to_i == fetch_vendor_id.to_i 
							payload << {user_account: user_account, address: address, amount: amount, date: date, vendor_id: vendor_id}
						end
					end
				end
			end
		end
		render json: {payment_history: payload}
	end

	def index_by_date
	end

	def vendors_with_transactions
		service_ids = PaymentHistory.where("status = 1 AND payment_type = '1' AND extract(month from created_at) = ?", params[:month]).pluck(:service_id)
		vendor_ids = Vendor.find(Service.find(service_ids).pluck(:vendor_id)).select(:id)
		render json: vendors_ids
	end
end
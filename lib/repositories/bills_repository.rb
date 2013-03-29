module BillsRepository
	def load_last_3_months current_month, current_user
		bills = where("extract(month from created_at) = ? and user_id = ? ", current_month, current_user.id)
		unless bills.empty?
			where("created_at >= ?", 3.months.ago)
		else
			where("created_at between ? and ?", 4.month.ago, 1.month.ago)
		end
	end

	def index_month_bill user, month
		sum_up_month user, month
	end

private
	def sum_up_month user, month
		month_bill = where("extract(month from created_at) = ? and user_id = ? ", month, user.id).select("sum(amount) as amount, extract(month from created_at) as month").group("created_at")
	end

	def sum_up_place user, month
		service_bill = sum_up_service user, []
	end

	def sum_up_service user, place

	end
end
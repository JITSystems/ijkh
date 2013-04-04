#!/bin/env ruby
# encoding: utf-8
class BillController < ApplicationController
	def index
		#bills = Bill.load_last_3_months(current_month, current_user)
		billys = Bill.index_month_bill current_user

		render json: billys
	end

	def paid_index
		billys = Bill.index_month_bill current_user, "= 1"
		render json: billys
	end

	def unpaid_index
		billys = Bill.index_month_bill current_user, "!= 1"
		render json: billys
	end

	def pay_bill
		url = Bill.pay_bill current_user, 300.01
	
		redirect_to url
	end

	def create
	end

	def destroy
		bill = Bill.find(params[:bill_id])
		if bill.destroy
			render json: {status: "deleted"}
		end
	end
end

# month_bill: {
#	amount: сумма за месяц
#	place_bill: {
#		title: Дом
#		amount: сумма за месяц по месту
#		service_bill: {
#			title: Вода
#			amount: сумма за месяц по услуге
#			}
#		}
#   }
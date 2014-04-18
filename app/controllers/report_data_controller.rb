class ReportDataController < ApplicationController
	# all actions are implemented in ReportDataManager class
	# lib/report_data_manger.rb
	def index_daily
		# GET api/1.0/report_daily
		# fetches all yesterday's transactions
		# params: none
		# renders json:
		# payload: [{user_account, amount, date, address, vendor_id}]
		payload = ReportDataManager.new(Date.yesterday, Date.today)
		render json: {payload: payload.index.first, terminal: payload.index.last}
	end

	def index_from_to
		# GET api/1.0/report_from_to
		# fetches all transactions in [from..to] period
		# params: from, to
		# renders json:
		# payload: [{user_account, amount, date, address, vendor_id}]
		payload = ReportDataManager.new(params[:from], params[:to])
		render json: {payload: payload.index.first, terminal: payload.index.last}
	end

	def index_hourly
		# GET api/1.0/report_hourly
		# fetches all transactions for the last 3 hours
		# params: none
		# renders json:
		# payload: [{user_account, amount, date, address, vendor_id}]
		payload = ReportDataManager.new(DateTime.now - 7.hour, DateTime.now - 4.hour)
		render json: {payload: payload.index.first, terminal: payload.index.last}
	end

	def index_monthly_by_vendor
		# GET api/1.0/report_monthly
		# fetches all transactions for given month and vendor_id
		# params: month, vendor_id
		# renders json:
		# payload: [{user_account, amount, date, address, vendor_id}]
		payload = ReportDataManager.index_by_vendor(params[:vendor_id], params[:month])
		render json: {payment_history: payload.first, terminal: payload.last}
	end

	def vendors_with_transactions
		# GET api/1.0/report_vendors
		# fetches ids of vendors that have transactions for given month
		# params: month
		# renders json:
		# [id, id, id, id]
		ids = ReportDataManager.vendors_with_transactions(params[:month])
		render json: ids
	end
end
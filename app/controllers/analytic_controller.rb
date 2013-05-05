class AnalyticController < ApplicationController
	def index
		@month_analytics = MonthAnalytic.get_annual current_user

		render 'analytic/index'
	end
end
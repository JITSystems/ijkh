class Admin::AnalyticQueriesController < AdminController
	def create
		@query = AnalyticQuery.create!(params[:analytic_query])
		redirect_to admin_analytic_queries_path
	end

	def show
	end

	def new
		@query = AnalyticQuery.new
	end

	def destroy
		AnalyticQuery.find(params[:id]).destroy
	end

	def update
		AnalyticQuery.find(params[:id]).update_attributes(params[:analytic_query])
		redirect_to admin_analytic_queries_path
	end

	def edit
		@query = AnalyticQuery.find(params[:id])
	end

	def index
		@queries = AnalyticQuery.all
	end
end
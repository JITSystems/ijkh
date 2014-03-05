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
		redirect_to admin_query_index_path
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
		render :index
	end

	def query_index
		@queries = AnalyticQuery.all
		render :query_index
	end

	def process_query
		@queries = AnalyticQuery.all
		@query = AnalyticQuery.find(params[:analytic_queries][:id])
		@result = ActiveRecord::Base.connection.execute(@query.query) if @query.query[0..5].downcase == 'select'
		render :index
	end
end
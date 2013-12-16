# encoding: utf-8
class Admin::Reports::TransactionsController < AdminController

  def create
  	@from = Date.parse(params[:transactions][:from])
  	@to = Date.parse(params[:transactions][:to])
  	@report_data = ReportDataManager.new(@from, @to).index
    
    respond_to do |format| 
    	format.xls { render xls: @report_data, filename: "test.xls", type: 'application/vnd.ms-excel'}
    end
  end

end

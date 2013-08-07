class FieldTemplateController < ApplicationController
	
	skip_before_filter :require_auth_token

	def index
		@field_templates = FieldTemplate.all
		render 'field_template/index'
	end

	def create
		@field_template = FieldTemplate.new(params[:field_template])
		@field_template.save
		render json: @field_template
	end
end
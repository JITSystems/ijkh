class FieldTemplateController < ApplicationController
	def index
		# GET api/1.0/fieldtemplate
		@field_templates = FieldTemplateManager.index
		render 'field_template/index'
	end

	def create
		# POST api/1.0/field_template
		@field_template = FieldTemplateManager.create(params[:field_template])
		render json: @field_template
	end
end
class FieldTemplateController < ApplicationController
	def index
		@field_templates = FieldTemplateManager.index
		render 'field_template/index'
	end

	def create
		@field_template = FieldTemplateManager.create(params)
		render json: @field_template
	end
end
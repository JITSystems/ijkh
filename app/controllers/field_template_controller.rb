class FieldTemplateController < ApplicationController
	def index
		@field_templates = FieldTemplateManager.index
		render 'field_template/index'
	end

	def create
		@field_template = FieldTemplateManager.create(params[:field_template])
		render json: @field_template
	end
end
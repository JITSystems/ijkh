class FieldTemplateController < ApplicationController
	def index
		@field_templates = FieldTemplate.includes(:values).all
		render json: @field_templates
	end
end
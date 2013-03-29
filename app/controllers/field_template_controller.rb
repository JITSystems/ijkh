class FieldTemplateController < ApplicationController
	def index
		field_templates = FieldTemplate.all
		render json: field_templates
	end
end
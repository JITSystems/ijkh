class FieldTemplateController < ApplicationController
	def index
		@field_templates = FieldTemplate.all
		render 'field_template/index'
	end
end
class FieldTemplateListValue < ActiveRecord::Base
  attr_accessible :field_template_id, :value

  belongs_to :field_template, foreign_key: :field_template_id
end

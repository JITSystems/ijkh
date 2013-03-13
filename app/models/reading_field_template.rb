class ReadingFieldTemplate < ActiveRecord::Base
  attr_accessible :field_template_id, :title

  belongs_to :field_template
end

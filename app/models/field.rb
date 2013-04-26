class Field < ActiveRecord::Base
	extend FieldsRepository
  
  	attr_accessible :field_type, :is_for_calc, :reading_field_title, :tariff_id, :title, :value, :field_template_id

  	belongs_to :tariff

  	has_many :meter_readings
  	has_many :field_list_values

  	def last_reading
  		self.meter_readings.last
  	end

end

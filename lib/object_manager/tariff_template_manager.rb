class TariffTemplateManager < ObjectManager	
	def self.create(params)
		TariffTemplate.create!(params[:tariff_template])
	end

	def self.index(service_type_id)
		tariff_templates = TariffTemplate.where("service_type_id = ? and vendor_id = 0", service_type_id)
		return tariff_templates
	end
end
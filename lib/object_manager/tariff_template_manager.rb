class TariffTemplateManager < ObjectManager	
	def self.create(params)
		TariffTemplate.create!(params[:tariff_template])
	end
end
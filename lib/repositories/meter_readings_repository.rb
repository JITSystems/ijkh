module MeterReadingsRepository
	
	def by_tariff tariff_id 
		where(tariff_id: tariff_id)
	end
	
end
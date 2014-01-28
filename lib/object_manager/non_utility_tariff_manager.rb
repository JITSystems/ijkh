class NonUtilityTariffManager < ObjectManager

	def self.index_by_vendor(non_utility_vendor_id)
		NonUtilityTariff.where(non_utility_vendor_id: non_utility_vendor_id)
	end
end
class NonUtilityVendorsContactManager < ObjectManager

	def self.create(params)
		NonUtilityVendorsContact.create(params[:non_utility_vendors_contacts])
	end
end
class AddPictureUrlToNonUtilityVendors < ActiveRecord::Migration
  	def up
    	add_column :non_utility_vendors, :picture_url, :string
  	end
  	
  	def down
  		remove_column :non_utility_vendors, :picture_url
	end
end

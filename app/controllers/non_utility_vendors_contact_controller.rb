class NonUtilityVendorsContactController < ApplicationController

  def create
  	  @non_utility_vendors_contacts = NonUtilityVendorsContactManager.create(params)
	  render json: @non_utility_vendors_contacts
  end
end

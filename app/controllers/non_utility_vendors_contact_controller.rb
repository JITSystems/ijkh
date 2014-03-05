class NonUtilityVendorsContactController < ApplicationController
	
  def create
  	  @non_utility_vendors_contacts = NonUtilityVendorsContactManager.create(params[:non_utility_vendors_contacts])
	  render json: @non_utility_vendors_contacts
  end
end

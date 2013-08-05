class AddIosDeviceFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :ios_device_token, :string 
  	add_column :users, :ios_device_status, :string
  end
end

class ChangeLastNameToPhoneNumberInUsers < ActiveRecord::Migration
  def up
  	rename_column :users, :last_name, :phone_number
  end

  def down
  	rename_column :users, :phone_number, :last_name
  end
end

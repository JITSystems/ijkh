class ChangeServiceTitleToServiceTypeTitleInBills < ActiveRecord::Migration
  def up
  	rename_column :bills, :service_title, :service_type_title
  end

  def down
  	rename_column :bills, :service_type_title, :service_title 
  end
end

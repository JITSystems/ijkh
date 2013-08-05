class AddIsActiveToServices < ActiveRecord::Migration
  def change
  	add_column :services, :is_active, :boolean
  end
end

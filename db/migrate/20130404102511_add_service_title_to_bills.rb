class AddServiceTitleToBills < ActiveRecord::Migration
  def change
    add_column :bills, :service_title, :string
  end
end

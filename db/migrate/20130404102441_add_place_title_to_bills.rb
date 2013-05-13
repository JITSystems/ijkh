class AddPlaceTitleToBills < ActiveRecord::Migration
  def change
    add_column :bills, :place_title, :string
  end
end

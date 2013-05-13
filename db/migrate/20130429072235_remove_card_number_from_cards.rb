class RemoveCardNumberFromCards < ActiveRecord::Migration
  def up
  	remove_column :cards, :card_number
  end

  def down
  	add_column :cards, :card_number, :integer
  end
end

class AddRebillAnchorToCards < ActiveRecord::Migration
  def change
    add_column :cards, :rebill_anchor, :string
  end
end

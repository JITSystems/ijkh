class AddCardTitleToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_title, :string
  end
end

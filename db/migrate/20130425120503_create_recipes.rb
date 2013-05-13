class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :amount
      t.string :total
      t.string :po_tax
      t.string :service_tax
      t.string :currency

      t.timestamps
    end
  end
end

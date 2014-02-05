class CreatePrecincts < ActiveRecord::Migration
  def change
    create_table :precincts do |t|
      t.string :ovd
      t.string :ovd_town
      t.string :ovd_street
      t.string :ovd_house
      t.string :ovd_telnumber
      t.string :surname
      t.string :middlename
      t.string :name
      t.string :photo_url

      t.timestamps
    end
  end
end

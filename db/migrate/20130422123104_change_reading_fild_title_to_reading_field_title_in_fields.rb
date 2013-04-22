class ChangeReadingFildTitleToReadingFieldTitleInFields < ActiveRecord::Migration
  def up
  	rename_column :fields, :reading_fild_title, :reading_field_title
  end

  def down
  	rename_column :fields, :reading_field_title, :reading_fild_title 
  end
end

class ChangeDescriptionTypeToText < ActiveRecord::Migration
  def up
  	change_column :freelancers, :description, :text
  end

  def down
  end
end

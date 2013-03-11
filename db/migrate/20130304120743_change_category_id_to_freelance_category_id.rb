class ChangeCategoryIdToFreelanceCategoryId < ActiveRecord::Migration
  def up
  	rename_column :freelancers, :category_id, :freelance_category_id
  end

  def down
  	rename_column :freelancers, :freelance_category_id,  :category_id
  end
end

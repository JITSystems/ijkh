class AddRecipeIdToFreelanceInterfaceTopTenFreelancer < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_top_ten_freelancers, :recipe_id, :integer
  end
end

class AddRecipeIdToFreelanceInterfaceTopFourFreelancer < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_top_four_freelancers, :recipe_id, :integer
  end
end
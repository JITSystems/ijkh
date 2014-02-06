class AddRecipeIdToFreelanceInterfaceFreelancer < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_freelancers, :recipe_id, :integer
  end
end

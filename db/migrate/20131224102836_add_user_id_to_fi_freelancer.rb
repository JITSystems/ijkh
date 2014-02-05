class AddUserIdToFiFreelancer < ActiveRecord::Migration
  def change
  	 add_column :freelance_interface_freelancers, :user_id, :integer
  end
end

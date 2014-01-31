class AddUserIdToFiComments < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_comments, :user_id, :integer
  end
end

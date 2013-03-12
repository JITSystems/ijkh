class AddUserAccountToServices < ActiveRecord::Migration
  def change
    add_column :services, :user_account, :string
  end
end

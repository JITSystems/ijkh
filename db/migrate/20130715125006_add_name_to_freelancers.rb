class AddNameToFreelancers < ActiveRecord::Migration
  def change
    add_column :freelancers, :name, :string
  end
end

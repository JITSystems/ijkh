class AddNumberOfMonthToFreelanceInterfaceTopFour < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_top_four_freelancers, :number_of_month, :integer
  end
end

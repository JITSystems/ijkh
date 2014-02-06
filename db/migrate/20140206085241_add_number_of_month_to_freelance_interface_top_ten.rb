class AddNumberOfMonthToFreelanceInterfaceTopTen < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_top_ten_freelancers, :number_of_month, :integer
  end
end


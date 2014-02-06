class AddNumberOfMonthToFreelanceInterfaceFreelancers < ActiveRecord::Migration
  def change
  	add_column :freelance_interface_freelancers, :number_of_month, :integer
  end
end

class AddServiceIdToFiFreelancers < ActiveRecord::Migration
  def change
  	 add_column :freelance_interface_freelancers, :service_id, :integer
  end
end

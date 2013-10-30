class AddPublishedToFreelancers < ActiveRecord::Migration
  def change
    add_column :freelancers, :published, :boolean
  end
end

class ChangeServiceTitleFromIntegerToStringInAnalytics < ActiveRecord::Migration
def self.up
   change_column :analytics, :service_title, :string
  end

  def self.down
   change_column :analytics, :service_title, :integer
  end
end

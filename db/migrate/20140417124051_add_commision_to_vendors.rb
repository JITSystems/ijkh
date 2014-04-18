class AddCommisionToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :commission_yandex, :float
    add_column :vendors, :commission_webmoney, :float
  end
end

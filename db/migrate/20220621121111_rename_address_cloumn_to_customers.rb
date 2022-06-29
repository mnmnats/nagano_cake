class RenameAddressCloumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :address, :residen
  end
end

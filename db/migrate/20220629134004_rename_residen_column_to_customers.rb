class RenameResidenColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :residen, :address
  end
end

class Rename < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :pyment_method, :payment_method
  end
end

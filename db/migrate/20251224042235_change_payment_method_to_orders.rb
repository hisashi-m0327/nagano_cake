class ChangePaymentMethodToOrders < ActiveRecord::Migration[6.1]
  def up
    change_column :orders, :payment_method, :integer, default: 0, null: false
  end

  def down
    change_column :orders, :payment_method, :string, default: "", null: false
  end
end

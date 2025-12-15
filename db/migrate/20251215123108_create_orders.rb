class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string  :postal_code, null: false
      t.string  :address, null: false
      t.string  :name, null: false
      t.integer :postage, null: false
      t.integer :billing_amount, null: false
      t.string  :payment_method, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end

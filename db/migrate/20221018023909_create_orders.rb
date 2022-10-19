class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.integer :customer_id     , null: false
      t.integer :postage         , null: false
      t.integer :billing_amount  , null: false
      # payment_method、order_status デフォを0にする
      t.integer :payment_method  , null: false
      t.string  :name            , null: false
      t.string  :address         , null: false
      t.string  :postcode        , null: false
      t.integer :order_status    , null: false

      t.timestamps
    end
  end
end

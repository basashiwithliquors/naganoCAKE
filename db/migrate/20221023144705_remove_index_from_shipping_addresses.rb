class RemoveIndexFromShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_index :shipping_addresses, :customer_id
  end
end

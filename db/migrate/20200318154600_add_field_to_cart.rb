class AddFieldToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :coupon_applied, :boolean
  end
end

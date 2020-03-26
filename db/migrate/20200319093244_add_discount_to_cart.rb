class AddDiscountToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :discount, :float
  end
end

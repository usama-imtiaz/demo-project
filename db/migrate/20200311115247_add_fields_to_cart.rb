class AddFieldsToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :gross_total, :integer
    add_column :carts, :net_total, :integer
  end
end

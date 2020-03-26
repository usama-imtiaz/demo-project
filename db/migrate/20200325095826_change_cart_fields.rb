class ChangeCartFields < ActiveRecord::Migration[6.0]
  def change
    change_column :carts, :net_total, :float
    change_column :carts, :gross_total, :float
  end
end

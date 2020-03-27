class ChangeTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :cart, :carts
  end
end

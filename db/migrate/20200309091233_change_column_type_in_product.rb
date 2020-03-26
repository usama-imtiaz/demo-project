class ChangeColumnTypeInProduct < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :serial_number, :string
  end
end

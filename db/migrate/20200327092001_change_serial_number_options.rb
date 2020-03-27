class ChangeSerialNumberOptions < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :serial_number, :string, null: true
  end
end

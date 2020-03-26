class AddFieldsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :name, :string
    add_column :products, :category, :string
    add_column :products, :serial_number, :string
    add_column :products, :in_stock, :integer
    add_column :products, :unit_price, :integer
    add_reference :products, :user, null: false, foreign_key: true
  end
end

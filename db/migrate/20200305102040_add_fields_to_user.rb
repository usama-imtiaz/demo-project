class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :integer
    add_column :users, :tax_id, :integer
    add_column :users, :address, :string
  end
end

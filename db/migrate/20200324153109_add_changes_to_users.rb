class AddChangesToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :phone, :string
    change_column :users, :tax_id, :string
  end
end

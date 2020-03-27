class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string,    null: false, length: { maximum: 50 }
    add_column :users, :phone, :string,   null: false, length: { maximum: 14 }
    add_column :users, :tax_id, :string,  null: false, length: { maximum: 20 }
    add_column :users, :address, :string, null: false, length: { maximum: 100 }
    add_column :users, :bio, :text,       null: false, length: { maximum: 200 }
  end
end

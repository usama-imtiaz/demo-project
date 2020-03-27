class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string      :name,          null: false, length: { maximum: 100 }
      t.string      :category,      null: false, length: { maximum: 50 }
      t.string      :serial_number, null: false
      t.integer     :stock,         null: false
      t.integer     :unit_price,    null: false
      t.text        :description
      t.references  :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

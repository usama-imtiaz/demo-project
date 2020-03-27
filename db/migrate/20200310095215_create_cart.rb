class CreateCart < ActiveRecord::Migration[6.0]
  def change
    create_table :cart do |t|
      t.float :gross_total,   null: false
      t.float :net_total,     null: false
      t.float :discount,      null: false
      t.jsonb :bucket,        null: false
      t.boolean :coupon_applied
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

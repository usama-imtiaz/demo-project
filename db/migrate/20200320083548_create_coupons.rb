class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string      :name,        null: false, length: { minimum:1, maximum:25 }
      t.float       :percentage,  null: false, precision: 3, scale: 2
      t.integer     :quantity,    null: false
      t.references  :user,        null: false, foreign_key: true

      t.timestamps
    end
  end
end

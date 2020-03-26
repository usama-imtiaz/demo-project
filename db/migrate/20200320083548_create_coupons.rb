class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.float :percentage
      t.integer :quantity

      t.timestamps
    end
  end
end

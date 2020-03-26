class DropTableCoupon < ActiveRecord::Migration[6.0]
  def change
    drop_table :coupons
  end
end

class AddUserToCoupon < ActiveRecord::Migration[6.0]
  def change
    add_reference :coupons, :user, null: false, foreign_key: true
  end
end

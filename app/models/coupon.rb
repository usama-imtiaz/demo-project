class Coupon < ApplicationRecord
  belongs_to :user

  validates :name, :percentage, :quantity, presence: true
  validates :name, length: { minimum:1, maximum:30 }
  validates :quantity,   numericality:   { only_integer: true }
  validates :percentage, numericality: { only_float: true }

  def applying_coupon user
    if !user.cart.coupon_applied
      user.cart.discount = self.percentage
      user.cart.coupon_applied = true
      user.cart.net_total -= (user.cart.net_total * user.cart.discount)
      user.cart.save
      true
    else
      false
    end
  end
end

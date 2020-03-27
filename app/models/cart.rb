class Cart < ApplicationRecord
  belongs_to :user

  validates :gross_total, :net_total, :discount, :bucket, presence: true
  validates :gross_total, :net_total, :discount, numericality: { only_float: true }
end

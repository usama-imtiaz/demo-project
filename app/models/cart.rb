class Cart < ApplicationRecord
  belongs_to :user

  validates :gross_total, :net_total, numericality: true
end

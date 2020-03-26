class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :comment, length: { maximum: 200 }, presence: true, allow_blank: false
end
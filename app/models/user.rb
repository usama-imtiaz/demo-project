class User < ApplicationRecord
  has_one_attached :image
  has_one :cart

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :coupons, dependent: :destroy

  validates :name, :email, :bio, :address, :tax_id, presence: true
  validates :name,    length: { maximum: 50  }
  validates :phone,   length: { maximum: 14  }, numericality: { only_integer: true }
  validates :bio,     length: { maximum: 200 }
  validates :address, length: { maximum: 200 }
  validates :tax_id,  length: { maximum: 30  }
  validates :email,   length: { maximum: 50  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def profile
    self.image.variant(resize: "300x300").processed
  end

  # def after_database_authentication
  # end
end

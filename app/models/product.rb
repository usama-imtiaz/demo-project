class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy

  validate :image_type
  validates :name,        length: { maximum: 100 }
  validates :category,    length: { maximum: 50  }
  validates :description, length: { maximum: 250 }
  validates :in_stock, :unit_price, numericality: { only_integer: true }
  validates :name, :category, :unit_price, :in_stock, presence: true

  before_save :add_serial_number
  after_save :update_index

  def thumbnail index
    self.images[index].variant(resize: "200x200").processed
  end

  # def thumbnail2 index
  #   self.images[index].variant(resize: "100x100").processed
  # end

  def image_type
    if images.attached? == false
      errors.add(:images, "are missing")
    end

    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'needs to be of type JPEG or PNG')
      end
    end
  end

  def add_serial_number 
    self.serial_number = self.category.first(3) + '-' + Random.rand(1000).to_s + '-' + self.id.to_s
  end

  def update_index
    system("rake ts:sql:index")
  end

  # scope :searchh, ->(term) { where("LOWER(name) LIKE ?", "%#{term.downcase}%") if term.present? }
end

class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_item, dependent: :destroy
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  with_options presence: true do
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true
  end
  def get_image
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image
  end
    validates :is_active, inclusion:{in: [true, false]}
    has_one_attached :item_image
    def add_tax_price
        (self.price * 1.10).round
    end
end
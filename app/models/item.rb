class Item < ApplicationRecord
  has_one_attached :image
  def get_image(width, height)
  end
  def add_tax_price
        (self.price * 1.10).round
  end
end

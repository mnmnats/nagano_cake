class OrderDetail < ApplicationRecord
  # 注文ステータス（0=着手不可 / 1=製作待ち / 2=製作中 / 3=製作完了）
  enum making_status: { 着手不可: 0, 制作待ち: 1, 制作中: 2, 制作完了: 3}

  belongs_to :order
  belongs_to :item
  
  def subtotal
    item.add_tax_price * amount
  end
  with_options presence: true do
    validates :making_status
    validates :price ,numericality: true
    validates :amount ,numericality: true
  end

end
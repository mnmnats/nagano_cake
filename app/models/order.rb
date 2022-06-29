class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details


 enum payment_method: { クレジットカード: 0, 銀行振り込み: 1 }
 enum status: { 入金待ち: 0 ,入金確認: 1 ,製作中: 2 ,発送準備中: 3 ,発送済み: 4 }
 
  with_options presence: true do
    validates :postal_code
    validates :address
    validates :name
    validates :shipping_cost ,numericality: true
    validates :total_payment ,numericality: true
    validates :payment_method
    validates :status
  end
end
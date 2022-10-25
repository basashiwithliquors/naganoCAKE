class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items, source: :item

  # enumで支払い方法定義
  enum payment_method: { credit_card: 0, transfer: 1 }

  # 注文ステータス定義
  enum order_status: {
    "waiting_payment":0,
    "payment_confirmation":1,
    "production":2,
    "shipping_preparation":3,
    "sent":4
  }
end

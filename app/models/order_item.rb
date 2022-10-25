class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

  # 注文ステータス定義
  enum production_status: {
    "impossible_making":0,
    "waiting_for_making":1,
    "making":2,
    "complete":3,
  }
end

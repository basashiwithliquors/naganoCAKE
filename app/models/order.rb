class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items, source: :item
  
  # enumで支払い方法定義
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  # 注文ステータス定義
  enum status: {
     "入金待ち":0, 
     "入金確認":1, 
     "製作中":2, 
     "発送準備中":3, 
     "発送済み":4
  }
end

class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items, source: :order
  
  has_one_attached :image
  
  def get_image
    if image.attached?
      image
    else
      "no_image.png"
    end
  end
  
  def price_in_tax
    result = price_without_tax * 1.1
    result.round.to_s(:delimited)
  end
  
  def price_ex_tax
    price_without_tax.to_s(:delimited)
  end
  
  # 消費税を求めるメソッド
  def with_tax_price
    (price_without_tax * 1.1).floor
  end 
end

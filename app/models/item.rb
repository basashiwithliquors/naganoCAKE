class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items, source: :order

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price_without_tax, presence: true, numericality: { only_integer: true }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  # 消費税を求める＋桁区切りを行うメソッド
  def price_in_tax
    (price_without_tax * 1.1).floor.to_s(:delimited)
  end

  # 商品価格（税抜）を桁区切りで表示するメソッド
  def price_ex_tax
    price_without_tax.to_s(:delimited)
  end

  # 消費税を求めるメソッド
  def with_tax_price
    (price_without_tax * 1.1).floor
  end
end

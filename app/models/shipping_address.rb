class ShippingAddress < ApplicationRecord
  belongs_to :customer
  
  validates :name, presence: true
  validates :postcode, presence: true, numericality: { only_integer: true }
  validates :address, presence: true

end

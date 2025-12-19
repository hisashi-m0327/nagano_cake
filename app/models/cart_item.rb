class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, numericality: { greater_than: 0 }

  def subtotal
    item.price_with_tax * amount
  end
  
end

class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre

  has_many :cart_items

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def price_with_tax
    (price * 1.1).floor
  end
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship

  belongs_to :user
  has_one_attached :item_image

  with_options numericality: { other_than: 1 } do
    validates :category_id, :item_status_id, :shipping_fee_id, :prefecture_id, :days_to_ship_id
  end

  with_options presence: true do
    validates :item_image, :name, :detail, :price
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end

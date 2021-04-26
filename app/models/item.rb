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
	
end

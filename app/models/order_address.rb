class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :user_id, :item_id, :token, :city, :address
  end
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'が無効です' }
  validates :prefecture_id, numericality: { only_integer: true, other_than: 1, message: 'を選択してください' }
  validates :phone_number, format: { with: /\A[0-9]{11}\z/, message: 'が無効です' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end

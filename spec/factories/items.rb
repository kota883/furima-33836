FactoryBot.define do
  factory :item do
    name                { Faker::Name.initials(number: 2) }
    detail              { Faker::Lorem.sentence(word_count: 3) }
    category_id         { 2 }
    item_status_id      { 2 }
    shipping_fee_id     { 2 }
    prefecture_id       { 2 }
    days_to_ship_id     { 2 }
    price               { 1000 }

    association :user

    after(:build) do |item|
      item.item_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
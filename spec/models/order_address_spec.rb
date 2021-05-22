require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(1) # Mysql2エラー防止
    end

    context '購入情報が保存できる時' do
      it '必要な情報を適切に入力すると商品の購入ができる' do
        expect(@order).to be_valid
      end
      it '建物名がなくても保存ができる' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '購入情報が保存できない時' do
      it 'クレジットカード情報が空では購入できない' do
        @order.token = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が空では購入できない' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code が無効です')
      end
      it '都道府県が未選択では購入できない' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('Prefecture を選択してください')
      end
      it '市区町村が空では購入できない' do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では購入できない' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では購入できない' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number が無効です')
      end
      it '郵便番号にハイフンがなければ購入できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code が無効です')
      end
      it '郵便番号が8桁以外では購入できない' do
        @order.postal_code = '123-456'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code が無効です')
      end
      it '郵便番号が全角数字では購入できない' do
        @order.postal_code = '１２３−４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal code が無効です')
      end
      it '電話番号が9桁以下の時購入できない' do
        @order.phone_number = '12345678'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number が無効です')
      end
      it '電話番号が12桁以上の時購入できない' do
        @order.phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number が無効です')
      end
      it '電話番号が全角数字では購入できない' do
        @order.phone_number = '０９００００００００００'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number が無効です')
      end
      it '電話番号が英数字混合では購入できない' do
        @order.phone_number = '090abcd1234'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number が無効です')
      end
      it '電話番号が記号混合では購入できない' do
        @order.phone_number = '090-0000-0000'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number が無効です')
      end
      it 'user_idが紐づいていないと購入できないこと' do
        @order.user_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていないと購入できないこと' do
        @order.item_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

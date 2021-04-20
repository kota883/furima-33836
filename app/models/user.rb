class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birthday, presence: true

  # パスワードは半角英数字混合での入力が必須
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  # ユーザー本名は全角（漢字・ひらがな・カタカナ）での入力が必須
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' } do
    validates :first_name
    validates :last_name
  end

  # ユーザー本名のフリガナは全角（カタカナ）での入力が必須
  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角（カタカナ）で入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end
end

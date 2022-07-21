# == Schema Information
#
# Table name: customers
#
#  id                     :integer          not null, primary key
#  address                :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  first_name_kana        :string           not null
#  is_deleted             :boolean          default(FALSE), not null
#  last_name              :string           not null
#  last_name_kana         :string           not null
#  postal_code            :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  telephone_number       :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#
class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders,     dependent: :destroy
  has_many :addresses,  dependent: :destroy

  with_options presence: true do
    validates :address
    validates :first_name
    validates :last_name
    with_options format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。' } do
      validates :first_name_kana
      validates :last_name_kana
    end
    with_options numericality: { only_integer: true } do
      validates :postal_code, length: {is: 7}
      validates :telephone_number
    end
  end
  validates :is_deleted, inclusion: { in: [true, false] }


  def full_name
    last_name + "　" + first_name
  end

  def full_name_kana
    last_name_kana + "　" + first_name_kana
  end

  def address_display
    '〒' + postal_code + ' ' + address
  end

  def all_with_tax_price
    cart_items.inject(0){|total, cart_item| total + cart_item.subtotal}
  end
end

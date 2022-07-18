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

  def full_name
    first_name + "　" + last_name
  end

  def full_name_kana
    first_name_kana + "　" + last_name_kana
  end

  def address_display
    '〒' + postal_code + ' ' + address
  end
end

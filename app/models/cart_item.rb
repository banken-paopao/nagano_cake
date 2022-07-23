# == Schema Information
#
# Table name: cart_items
#
#  id          :integer          not null, primary key
#  amount      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#  item_id     :integer          not null
#
class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  with_options presence: true do
    validates :amount, numericality: { only_integer: true, greater_than: 0 }
    validates :customer_id
    validates :item_id
  end
end

# == Schema Information
#
# Table name: order_details
#
#  id            :integer          not null, primary key
#  amount        :integer          not null
#  making_status :integer          default("cant"), not null
#  price         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  item_id       :integer          not null
#  order_id      :integer          not null
#
class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { cant: 0,wait: 1,now: 2,finish: 3}

  with_options presence: true do
    validates :amount, numericality: { only_integer: true, greater_than: 0 }
    validates :price, numericality: { only_integer: true }
    validates :item_id
    validates :order_id
  end
  validates :making_status, inclusion: { in: OrderDetail.making_statuses.keys }

  def subtotal
    item.with_tax_price * amount
  end
end

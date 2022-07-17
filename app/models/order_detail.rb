# == Schema Information
#
# Table name: order_details
#
#  id            :integer          not null, primary key
#  amount        :integer          not null
#  making_status :integer          default(0), not null
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
  
  def subtotal
    item.with_tax_price * amount
  end
end

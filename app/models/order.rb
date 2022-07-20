# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  address        :string           not null
#  name           :string           not null
#  payment_method :integer          default("credit_card"), not null
#  postal_code    :string           not null
#  shipping_cost  :integer          not null
#  status         :integer          default("wait"), not null
#  total_payment  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer          not null
#
class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {credit_card: 0, transfar: 1}
  enum status: {wait: 0, confirm: 1, making: 2, preparing: 3, finish: 4}


  with_options presence: true do
    validates :address
    validates :name
    validates :postal_code, length: {is: 7}
    validates :shipping_cost, numericality: { only_integer: true }
    validates :customer_id
  end
  validates :payment_method, inclusion: { in: Order.payment_methods.keys }
  validates :status, inclusion: { in: Order.statuses.keys }


  def default_sipping_cost
    #配送料
    return 800
  end

  def address_display
    '〒' + postal_code.to_s + ' ' + address
  end

  def total_amount
    self.order_details.inject(0){|total, order_detail| total + order_detail.amount}
  end
end

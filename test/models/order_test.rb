# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  address        :string           not null
#  name           :string           not null
#  payment_method :integer          default(0), not null
#  postal_code    :string           not null
#  shipping_cost  :integer          not null
#  status         :integer          default(0), not null
#  total_payment  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  customer_id    :integer          not null
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

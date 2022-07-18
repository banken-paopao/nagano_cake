# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  address     :string           not null
#  name        :string           not null
#  postal_code :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#
class Address < ApplicationRecord
  belongs_to :customer

  def address_display
    '〒' + postal_code + ' ' + address + '　' + name
  end
end

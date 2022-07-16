# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  introduction :text             not null
#  is_active    :boolean          default(TRUE), not null
#  name         :string           not null
#  price        :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  genre_id     :integer          not null
#
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

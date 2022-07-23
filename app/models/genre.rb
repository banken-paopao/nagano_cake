# == Schema Information
#
# Table name: genres
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.create_order(create_time)
    page(create_time).order(created_at: :DESC)
  end

  def self.update_order(update_time)
    page(update_time).order(updated_at: :DESC)
  end
end

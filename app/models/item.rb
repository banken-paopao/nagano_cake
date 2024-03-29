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
class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items,    dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :favorites,     dependent: :destroy

  has_one_attached :image

  with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :introduction, length: { maximum: 400 }
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
  validates :is_active, inclusion: { in: [true, false] }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def with_tax_price
    (price * 1.1).floor
  end

  def sale_status
    is_active ? "販売中" : "販売停止中"
  end

  def self.search_for(model, search_value)
    if model == "item"
      Item.where("name LIKE ?", "%#{search_value}%")
    else
      Item.where(genre_id: search_value)
    end
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end

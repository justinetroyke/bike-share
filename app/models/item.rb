class Item < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :description,
                        :image_url

  has_many :order_items
  has_many :orders, through: :order_items
end

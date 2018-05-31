class Accessory < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :description
  validates_uniqueness_of :title
  validates :price, numericality: { :greater_than => 0 }
  has_many :order_accessories
  has_many :orders, through: :order_accessories
end

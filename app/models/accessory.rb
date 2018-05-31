class Accessory < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :description
  validates_uniqueness_of :title
  
  has_many :order_accessories
  has_many :orders, through: :order_accessories
end

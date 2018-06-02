class Accessory < ApplicationRecord
  validates_presence_of :title,
                        :price,
                        :description,
                        :status,
                        :image_url

  validates_uniqueness_of :title

  # validates :status, inclusion: { in: [0,1] }
  enum status: {active: 0, inactive: 1}

  validates :price, numericality: { :greater_than => 0 }

  has_many :order_accessories
  has_many :orders, through: :order_accessories
end

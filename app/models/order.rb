class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories
  def total
    accessories.sum(:price)
  end
  def quantity 
    order_accessories.count
  end

  #returns a hash with item id as the key and subtotal as the value
  def accessories_with_subtotal
    accessories.group(:id)
      .sum(:price)
  end

  def self.ordered
  end

  def self.paid
  end

  def self.cancelled
  end

  def self.completed
  end

end

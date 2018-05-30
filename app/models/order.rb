class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  def total
    items.sum(:price)
  end
  def quantity 
    order_items.count
  end

  #returns a hash with item id as the key and subtotal as the value
  def items_with_subtotal
    items.group(:id)
      .sum(:price)
  end
end

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
    where(status:"Ordered")
  end

  def self.paid
    where(status:"Paid")
  end

  def self.cancelled
    where(status:'Cancelled')
  end

  def self.completed
    where(status:'Completed')
  end

end

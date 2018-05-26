class Order < ApplicationRecord
  validates_presence_of :status,
                        :quantity

  belongs_to :user
end

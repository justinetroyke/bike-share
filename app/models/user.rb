class User < ApplicationRecord
  has_secure_password
  validates_presence_of :role
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :address
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :password, confirmation: true

  has_many :orders
end

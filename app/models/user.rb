class User < ApplicationRecord
  validates :role, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :address, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_presence_of :password, require: true, on: :create

  has_secure_password

  has_many :orders
end

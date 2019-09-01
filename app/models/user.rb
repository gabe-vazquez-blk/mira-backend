class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  validates :email, uniqueness: true
  has_secure_password
end

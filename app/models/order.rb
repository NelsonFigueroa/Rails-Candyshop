class Order < ApplicationRecord

  validates :customer_id, presence: true
  validates :store_id, presence: true
  validates :candy_name, presence: true
  validates :candy_price, presence: true
  validates :amount, presence: true

  validates_numericality_of :candy_price
  validates_numericality_of :amount
end

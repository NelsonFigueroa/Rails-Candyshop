class Shop < ApplicationRecord

  has_many :candies
  has_many :shelves

  validates :name, presence: true
  validates :city, presence: true

end

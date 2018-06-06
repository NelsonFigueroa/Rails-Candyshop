class Shop < ApplicationRecord

  has_many :candies
  has_many :shelves

end

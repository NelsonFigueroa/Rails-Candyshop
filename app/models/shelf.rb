class Shelf < ApplicationRecord

  belongs_to :shop
  has_many :candies
  
end

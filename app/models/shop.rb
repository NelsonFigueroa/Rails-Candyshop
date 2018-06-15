class Shop < ApplicationRecord

  belongs_to :user
  has_many :candies, :dependent => :destroy
  has_many :shelves, :dependent => :destroy

  validates :name, presence: true
  validates :city, presence: true

end

class Shop < ApplicationRecord

  belongs_to :user
  has_many :candies, :dependent => :destroy
  has_many :shelves, :dependent => :destroy

  validates :name, presence: true
  validates :city, presence: true

  scope :sorted, lambda { order("name ASC") }

  # Used to make sure shop indeed belongs to current user
  def shop_belongs_to_user(current_user)
    if self.user_id == current_user.id
      return true
    else
      return false
    end
  end

end

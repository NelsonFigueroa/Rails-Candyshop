class Shelf < ApplicationRecord

  belongs_to :shop
  has_many :candies

  # Used to make sure shelf belongs to the current user
  def shelf_belongs_to_user(current_user)
    if self.shop.user_id == current_user.id
      return true
    else
      return false
    end
  end

end

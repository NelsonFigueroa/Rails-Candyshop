class Candy < ApplicationRecord

  belongs_to :shop
  belongs_to :shelf, optional: true

  validates :name, presence: true
  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
  validates :price, :presence => true, :numericality => { :greater_than => 0 }
  validates_numericality_of :shelf_id, allow_nil: true

  scope :unshelved, lambda { where(:shelf_id => nil) }
  scope :shelved, lambda { where.not(:shelf_id => nil) }

  # Used to ensure that candy is in a shelf within the same shop
  def valid_shelf(shelf_id)
    # If shelf_id is not nil, check to make sure it exists, then check if it is in same shop
    if Shelf.exists?(id: shelf_id)
      @shelf = Shelf.find(shelf_id)
      # Check to see if shelf is in the same shop as candy
      if self.shop.id == @shelf.shop.id
        return true
      else
        # Candy and shelf are in different shops
        return false
      end
    else
      # Shelf does not not exist
      return false
    end
  end # End valid_shelf method

  # Used to make sure candy belong to appropriate shop
  def candy_belongs_to_user(current_user)
    if self.shop.user_id == current_user.id
      return true
    else
      return false
    end
  end

end

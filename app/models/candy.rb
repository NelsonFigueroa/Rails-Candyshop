class Candy < ApplicationRecord

  belongs_to :shop
  belongs_to :shelf, optional: true

  validates :name, presence: true
  validates :amount, :presence => true, :numericality => { :greater_than => 0 }
  validates_numericality_of :shelf_id, allow_nil: true

  scope :unshelved, lambda {where(:shelf_id => nil)}
  scope :shelved, lambda {where.not(:shelf_id => nil)}

  # Or ...
  # Create a drop down menu of all shelves. Less room for average user to make an error.
  # @candy.shop.shelves
  # Put in an option to unshelf a candy manually
end

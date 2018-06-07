class Candy < ApplicationRecord

  belongs_to :shop
  belongs_to :shelf, optional: true

  validates :name, presence: true
  validates :amount, presence: true
  validates_numericality_of :amount

  scope :unshelved, lambda {where(:shelf_id => nil)}
  scope :shelved, lambda {where.not(:shelf_id => nil)}

end

class Candy < ApplicationRecord

  belongs_to :shop
  belongs_to :shelf, optional: true

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates_numericality_of :shelf_id, allow_nil: true

  scope :unshelved, lambda {where(:shelf_id => nil)}
  scope :shelved, lambda {where.not(:shelf_id => nil)}

end

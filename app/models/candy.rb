class Candy < ApplicationRecord

  belongs_to :shop
  # belongs_to :shelf, optional: true

  # validates :amount, presence: true

  scope :unshelved, lambda {where(:shelf_id => nil)}
  scope :shelved, lambda {where.not(:shelf_id => nil)}

end

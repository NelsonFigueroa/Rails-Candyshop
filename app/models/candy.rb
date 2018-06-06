class Candy < ApplicationRecord

  belongs_to :shop
  # belongs_to :shelf, optional: true

  # after_initialize :set_defaults

  # def set_defaults
    # self.shelf_id = nil
  # end

  # validates :amount, presence: true

  scope :unshelved, lambda {where(:shelf_id => nil)}
  scope :shelved, lambda {where.not(:shelf_id => nil)}

end

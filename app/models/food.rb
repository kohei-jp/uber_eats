class Food < ApplicationRecord
  belongs_to :resutaurant
  has_one :line_foods
  belongs_to :orders
end
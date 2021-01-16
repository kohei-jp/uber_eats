class Restaurant < ApplicationRecord
  DEFAULT_NAME_LENGTH = 30
  has_many :foods
  has_many :line_foods, through: :foods
  belongs_to :order, optional: true # 外部キーのnilを許可する

  validates :name, :fee, :time_required, presence: true
  validates :name, length: { maximum: DEFAULT_NAME_LENGTH }
  validates :fee, numericality: { greater_than: 0 }
end
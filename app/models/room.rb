class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :area, presence: true, inclusion: { in: ["Tokyo", "Osaka", "Kyoto", "Sapporo"] }
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guests, presence: true
end

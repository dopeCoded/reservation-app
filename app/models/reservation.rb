class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guests, presence: true

  validate :check_in_date_cannot_be_in_the_past
  validate :check_out_after_check_in

  validates :guests, numericality: { greater_than_or_equal_to: 1, message: "At least one person" }

  def total_cost
    self.room.price * self.guests * ((self.check_out - self.check_in) / 86400).to_i
  end  

  private

  def check_in_date_cannot_be_in_the_past
    if check_in.present? && check_in < Date.today
      errors.add(:check_in, "can't be in the past")
    end
  end

  def check_out_after_check_in
    return if check_out.blank? || check_in.blank?

    if check_out < check_in
      errors.add(:check_out, "must be after the check in date")
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :videogame

  validates :start_time, :end_time, presence: true
  validate :start_time_cannot_be_in_the_past
  validate :end_after_start
  validate :no_overlapping_bookings

  private

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Date.today
      errors.add(:start_time, "cannot be in the past")
    end
  end

  def end_after_start
    return if end_time.blank? || start_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def no_overlapping_bookings
    return unless videogame && start_time && end_time

    overlap = Booking.where(videogame_id: videogame.id)
                     .where.not(id: id)
                     .where(status: ['pending', 'accepted']) # ← On filtre ici
                     .where("start_time < ? AND end_time > ?", end_time, start_time)
                     .exists?

    if overlap
      errors.add(:base, "This videogame is already booked for the selected dates.")
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :videogame

  validates :start_time, :end_time, presence: true

  validate :start_time_cannot_be_in_the_past

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Date.today
      errors.add(:start_time, "cannot be in the past")
    end
  end

  private

  def end_after_start
    return if end_time.blank? || start_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end

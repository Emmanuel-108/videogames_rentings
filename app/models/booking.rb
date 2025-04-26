class Booking < ApplicationRecord
  belongs_to :customer, class_name: "user", foreign_key: "customer_id"
  belongs_to :videogame, class_name: "Videogame", foreign_key: "videogame_id"
  validates :start_time, :end_time, presence: true

  private

  def end_after_start
    return if end_time.blank? || start_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end

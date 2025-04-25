class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :videogame

  validates :start_time, :end_time, presence: true
  validate :end_after_start

end

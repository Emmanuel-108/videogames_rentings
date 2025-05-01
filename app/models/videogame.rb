class Videogame < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id", optional: true
  has_many :bookings
  has_one_attached :photo

  CATEGORIES = [
    "Action",
    "Adventure",
    "RPG",
    "Shooter",
    "Strategy",
    "Simulation",
    "Sports",
    "Racing",
    "Puzzle",
    "Fighting"
  ].freeze

  validates :name, :description, :category, :price, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :rating, presence: true, numericality: { only_integer: false, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  private

  def set_defaults
    self.background_image ||= "https://example.com/default-poster.jpg"
    self.rating ||= 5.0
    self.category ||= "Action"
  end
end

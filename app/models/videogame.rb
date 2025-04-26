class Videogame < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :bookings

  validates :name, :description, :rating, :price, presence: true
end

class Videogame < ApplicationRecord

  has_many :bookings

  validates :name, :description, :rating, :price, presence: true
end

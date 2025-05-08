class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :videogames
  has_many :bookings
  has_one_attached :photo

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: /\A.*@.*\.com\z/, message: "must be a valid .com address" }
end

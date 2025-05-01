class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookings = current_user.bookings.where(status: ["accepted", "unpaid"]).includes(:videogame)

    @total_price = @bookings.sum do |b|
      days = (b.end_time.to_date - b.start_time.to_date).to_i + 1
      b.videogame.price * days
    end
  end

  def confirm_payment
    current_user.bookings.where(status: ["accepted", "unpaid"]).update_all(status: "paid")
    flash[:notice] = "Payment confirmed!"
    redirect_to root_path
  end
end

class CheckoutController < ApplicationController
  def show
    @bookings = current_user.bookings.includes(:videogame)

    @total_price = @bookings.sum do |b|
      days = (b.end_time.to_date - b.start_time.to_date).to_i + 1
      b.videogame.price * days
    end
  end

  def confirm_payment
    flash[:notice] = "Payment confirmed!"
    redirect_to root_path
  end
end

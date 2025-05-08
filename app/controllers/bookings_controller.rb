class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def new
    @videogame = Videogame.find(params[:videogame_id])

    if @videogame.user == current_user
      redirect_to videogame_path(@videogame), alert: "You cannot rent your own game."
      return
    end

    @booking = @videogame.bookings.new
  end

  def create
    @videogame = Videogame.find(params[:videogame_id])

    if @videogame.user == current_user
      redirect_to videogame_path(@videogame), alert: "You cannot rent your own game."
      return
    end

    @booking = @videogame.bookings.build(booking_params)
    @booking.user = current_user

    @booking.status = @videogame.user_id.nil? ? "unpaid" : "pending"

    if @booking.save
      redirect_to checkout_path, notice: "Booking added to your cart."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: "Booking successfully cancelled!"
  end

  def accept
    booking = Booking.find(params[:id])
    if booking.videogame.owner == current_user
      booking.update(status: "accepted")
      redirect_to my_videogames_path, notice: "Booking accepted."
    else
      redirect_to root_path, alert: "Unauthorized."
    end
  end

  def reject
    booking = Booking.find(params[:id])
    if booking.videogame.owner == current_user
      booking.update(status: "rejected")
      redirect_to my_videogames_path, notice: "Booking rejected."
    else
      redirect_to root_path, alert: "Unauthorized."
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end

end

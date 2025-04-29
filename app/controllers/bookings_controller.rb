class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings
  end

  def new
    @videogame = Videogame.find(params[:videogame_id])
    @booking = @videogame.bookings.new
  end

  def create
    @videogame = Videogame.find(params[:videogame_id])
    @booking = @videogame.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to videogame_path(@booking.videogame), notice: "Your rental has been successfully created ! 🎮"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: "Booking successfully cancelled!"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end

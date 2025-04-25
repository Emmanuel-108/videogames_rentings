class BookingsController < ApplicationController
  def new
    @videogame = Videogame.find(params[:videogame_id])
    @booking = @videogame.bookings.new
  end

  def create
    @videogame = Videogame.find(params[:videogame_id])
    @booking = @videogame.bookings.build(booking_params)
    if @booking.save
      redirect_to videogame_path(@booking.videogame)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to videogame_path(@booking.videogame), status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end
end

class RoomsController < ApplicationController

  # GET /rooms
  def index
    if verified_dates
      @rooms = Room.available(Date.parse(params[:begin]), Date.parse(params[:end]))
    else
      @rooms = Room.all
    end
    @booking = Booking.new
  end

  private

  def verified_dates
    if params[:begin] && params[:end]
      date_format = /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/
      params[:begin].match(date_format).present? && params[:end].match(date_format).present?
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:superficy, :price, :capacity)
  end
end

class BookingsController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_booking, only: [:destroy]

  def index
    @bookings = Booking.all
  end

  def create
    rooms = booking_params[:room_ids].select { |key, val| val != '0'}

    clean_params = booking_params.tap { |p| p.delete("room_ids") }

    begin
      rooms.keys.each_with_index do |room_id, index|
        clean_params[:room_id] = room_id
        @booking = @user.bookings.new(clean_params)
        @booking.save!
      end

      flash[:notice] = "Bookings successfully created"
      redirect_to action: "index"
    rescue => e
      puts "BOOKING CREATION ERROR : #{e}"
      flash[:alert] = "Error while creating a new booking"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @booking.destroy
      flash[:notice] = 'Booking has been successfully destroyed'
    else
      flash[:notice] = 'Error while destroying the booking'
    end
    redirect_back(fallback_location: root_path)
  end

  # Download a CSV list of the bookings
  def download
    @csv_list = Booking.order(:status)
    authorize @csv_list

    respond_to do |format|
      format.html
      format.csv { send_data @csv_list.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  private

  def set_user
    @user = current_user
  end

  def booking_params
    params.require(:booking).permit(:start, :end_day, :status, :user_id, :room_ids => {})
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end

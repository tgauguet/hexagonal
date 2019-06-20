class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_booking, only: [:destroy]
  before_action :set_bookings, only: [:download, :send_file]
  include ApplicationHelper

  def index
    @bookings = Booking.sort_by(params[:column], params[:direction]).includes(:room)
    @columns = {'name':'Name', 'start':'Start', 'end_day':'End'}
  end

  # Download a CSV list of the bookings
  def download
    authorize @bookings

    BookingsWorker.perform_async(@user.email, params['format'])
    flash[:notice] = "🎉🎉🎉 We just sent you the booking list in #{params['format']}"
    redirect_back(fallback_location: root_path)
  end

  def list
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
      puts "ERROR IN BookingsController METHOD create :\n#{e}" if Rails.env.production?
      flash[:alert] = "Error while creating a new booking"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    begin
      @booking.destroy!
      flash[:notice] = 'Booking has been successfully destroyed'
    rescue => e
      puts "ERROR IN BookingsController METHOD destroy :\n#{e}"
      flash[:alert] = 'Error while destroying the booking'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = current_user
  end

  def booking_params
    params.require(:booking).permit(:start, :column, :end_day, :status, :user_id, :room_ids => {})
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_bookings
    @bookings = Booking.all
  end

end

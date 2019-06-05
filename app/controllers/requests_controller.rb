class BookingsController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  before_action :set_and_authorize_booking, only: [:accept, :destroy]

  def index
    @confirmed = Booking.confirmed.first_come_first_served.limit(20)
    @accepted = Booking.accepted.limit(20)
    @expired = Booking.expired.limit(20)
    @pending = Booking.unconfirmed.limit(20)
  end

  def download
    @csv_list = Booking.order(:status)
    authorize @csv_list

    respond_to do |format|
      format.html
      format.csv { send_data @csv_list.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def accept
    if @booking.accept!
      flash[:notice] = 'Booking has been successfully accepted'
    else
      flash[:notice] = 'Error while accepting the booking'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @booking.destroy
      flash[:notice] = 'Booking has been successfully destroyed'
    else
      flash[:notice] = 'Error while destroying the booking'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_and_authorize_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

end

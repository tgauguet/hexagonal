class RequestsController < ApplicationController
  require 'csv'
  before_action :authenticate_user!
  before_action :set_and_authorize_request, only: [:accept, :destroy]

  def index
    @confirmed = Request.confirmed.first_come_first_served.limit(20)
    @accepted = Request.accepted.limit(20)
    @expired = Request.expired.limit(20)
    @pending = Request.unconfirmed.limit(20)
  end

  def download
    @csv_list = Request.order(:status)
    authorize @csv_list

    respond_to do |format|
      format.html
      format.csv { send_data @csv_list.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def accept
    if @request.accept!
      flash[:notice] = 'Request has been successfully accepted'
    else
      flash[:notice] = 'Error while accepting the request'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @request.destroy
      flash[:notice] = 'Request has been successfully destroyed'
    else
      flash[:notice] = 'Error while destroying the request'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_and_authorize_request
    @request = Request.find(params[:id])
    authorize @request
  end

end

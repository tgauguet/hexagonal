class RequestsController < ApplicationController

  def index
    @confirmed = Request.confirmed.first_come_first_served.limit(20)
    @accepted = Request.accepted.limit(20)
    @expired = Request.expired.limit(20)
    @pending = Request.unconfirmed.limit(20)
  end

  def destroy
    @request = Request.find(params[:id])
    if @request.destroy
      flash[:notice] = 'Request has been successfully destroyed'
    else
      flash[:notice] = 'Error while destroying the request'
    end

    redirect_back(fallback_location: root_path)
  end

end

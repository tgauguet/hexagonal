class RequestsController < ApplicationController

  def index
    @confirmed = Request.confirmed.first_come_first_served.limit(20)
    @accepted = Request.accepted.limit(20)
    @expired = Request.expired.limit(20)
    @pending = Request.unconfirmed.limit(20)
  end

end

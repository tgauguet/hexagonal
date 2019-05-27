class RequestsController < ApplicationController

  def index
    @confirmed = Request.confirmed.limit(20)
    @accepted = Request.accepted.limit(20)
    @expired = Request.expired.limit(20)
    @pending = Request.unconfirmed.limit(20)
  end

end

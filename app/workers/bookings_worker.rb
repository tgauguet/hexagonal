class BookingsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(*args)
    ApplicationMailer.bookings_email(args[0], args[1]).deliver_later
  end
end

class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  validates_presence_of :name, :superficy, :capacity, :price
  validates_numericality_of :capacity, :superficy

  scope :unavailable, -> (start_date, end_date) {
    joins(:bookings)
    .merge(Booking.with_existing_slot(start_date, end_date))
  }

  scope :available, -> (start_date, end_date) {
    Room.where.not(id: Room.unavailable(start_date, end_date).ids)
  }

end

class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :name, :bio, :phone_number
  validates_length_of :bio, minimum: 50
  validates_numericality_of :phone_number, length: { minimum: 10, maximum: 15 }

  scope :with_pending_reconfirmation, -> { joins(:booking).merge(Booking.to_reconfirm) }

  after_create :create_booking

  def admin?
    self.admin
  end

  private

  # Create a new booking with pending confirmation status
  def create_booking
    self.create_booking!
  end

  # Override Devise::Confirmable#after_confirmation
  def after_confirmation
    status = (Booking.accepted.count < 20 && !Booking.confirmed) ? 'accepted' : 'confirmed'
    self.booking.update(status: status)
  end

end

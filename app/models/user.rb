class User < ApplicationRecord
  has_one :request, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :name, :bio, :phone_number
  validates_length_of :bio, minimum: 50
  validates_numericality_of :phone_number, length: { minimum: 10, maximum: 15 }
  validates_format_of :name, with: /\A[a-zA-Z ]+\z/ # should only contain letters

  scope :with_pending_reconfirmation, -> { joins(:request).merge(Request.to_reconfirm) }

  after_create :create_request

  private

  # Create a new request with pending confirmation status
  def create_request
    self.create_request!
  end

  # Override Devise::Confirmable#after_confirmation
  def after_confirmation
    status = Request.accepted.count < 20 ? 'accepted' : 'confirmed'
    self.request.update(status: status)
  end

  def waiting_number
    Request.confirmed.count
  end

end

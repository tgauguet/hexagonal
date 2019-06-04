class User < ApplicationRecord
  has_one :request, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :name, :bio, :phone_number
  validates_length_of :bio, minimum: 50
  validates_numericality_of :phone_number, length: { minimum: 10, maximum: 15 }

  scope :with_pending_reconfirmation, -> { joins(:request).merge(Request.to_reconfirm) }

  after_create :create_request

  def admin?
    self.admin
  end

  private

  # Create a new request with pending confirmation status
  def create_request
    self.create_request!
  end

  # Override Devise::Confirmable#after_confirmation
  def after_confirmation
    status = (Request.accepted.count < 20 && !Request.confirmed) ? 'accepted' : 'confirmed'
    self.request.update(status: status)
  end

end

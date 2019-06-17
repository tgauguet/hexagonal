class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates_presence_of :name, :bio, :phone_number
  validates_length_of :bio, minimum: 50
  validates :phone_number, length: { minimum: 10, maximum: 15 }

  def admin?
    self.admin
  end

end

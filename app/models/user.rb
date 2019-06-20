class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable
  validates_presence_of :name # removed for omniauth compliancy , :bio, :phone_number
  validates_length_of :bio, minimum: 50, unless: :skip_bio_validation
  validates :phone_number, length: { minimum: 10, maximum: 15 }, unless: :skip_phone_number_validation
  
  attr_accessor :skip_bio_validation, :skip_phone_number_validation

  def admin?
    self.admin
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid)
    .first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    user.confirm
    user
  end

end

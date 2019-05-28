class Request < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates_presence_of :user_id, :status, on: :create
  validates :status, inclusion: { in: %w( pending confirmed accepted expired ) }

  # not allowed in the waiting list
  scope :first_come_first_served, -> { order('created_at ASC') }
  scope :unconfirmed, -> { where(status: 'pending') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :expired, -> { where(status: 'expired') }

  # that need to receive a confirmation email
  scope :to_reconfirm, -> { confirmed
                              .where(pending_reconfirmation: false)
                              .where("requests.updated_at < ?", 3.months.ago) }

  # for which reconfirmation time has expired ( 48h )
  scope :overtimed_confirmation, -> { confirmed
                              .where(pending_reconfirmation: true)
                              .where("updated_at < ?", 2.days.ago) }

  # Send pending confirmation email every 3 months
  def self.send_reconfirmation
    begin
      User.with_pending_reconfirmation.each do |user|
        ApplicationMailer.reconfirm_email(user).deliver
        user.request.update(pending_reconfirmation: true)
      end
    rescue => error
      puts "An error occcured while initializing waiting list : #{error}"
    end
  end

  # After 48 hours, all unreconfirmed requests are marked as 'expired'
  def self.clean
    puts "cleaning #{Request.overtimed_confirmation.count} user"
    Request.overtimed_confirmation.update_all(status: "expired")
  end

  def current_position
    ids_list = Request.confirmed
                      .map(&:user_id)
                      .index(self.user_id) + 1
  end

  # accept an existing request if there is a spot left
  def accept!
    if Request.accepted.count < 20
      self.update(status: 'accepted')
    else
      puts 'Can not accept this request, the list is full.'
    end
  end

end

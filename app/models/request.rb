class Request < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :status, on: :create

  # not allowed in the waiting list
  scope :unconfirmed, -> { where(email_confirmed: false) }

  scope :first_come_first_served, -> { order('created_at ASC') }
  scope :unexpired, -> { where.not(status: 'expired') }
  scope :accepted, -> { where(status: "accepted") }
  scope :expired, -> { where(status: "expired") }

  # allowed in the waiting list
  scope :confirmed, -> { unexpired
                              .where(email_confirmed: true)
                              .where(accepted_in_list: false) }

  # that need to receive a confirmation email
  scope :to_reconfirm, -> { unexpired
                              .confirmed
                              .where(pending_reconfirmation: false)
                              .where("requests.updated_at < ?", 5.minutes.ago) } # replace with 3 months ago

  # for which reconfirmation time has expired
  scope :overtimed_confirmation, -> { unexpired
                              .where(pending_reconfirmation: true)
                              .where("updated_at < ?", 10.minutes.ago) } # replace with 2 days ago

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

  # After 48 hours, get all the unreconfirmed request and mark them as expired
  def self.clean
    Request.overtimed_confirmation.update_all(status: "expired")
  end

  # accept an existing request
  def accept! id

  end

end

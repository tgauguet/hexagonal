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
  scope :confirmed, -> { unexpired.where(email_confirmed: true).where(accepted_in_list: false) }

  # that need to receive a confirmation email
  scope :to_reconfirm, -> { unexpired.confirmed.where("requests.updated_at < ?", 5.minutes.ago) } # replace with 3 months ago

  # for which reconfirmation time has expired
  scope :overtimed_confirmation, -> { unexpired.where(pending_reconfirmation: true).where("updated_at < ?", 2.days.ago) } # replace with 2 days ago

  # Cron job every 3 months
  # 1. Get all requests unconfirmed since 3 months
  # 2. For each request, send a confirmation email
  def self.init_waiting_list
    # begin
      User.with_pending_reconfirmation.each do |user|
        ApplicationMailer.reconfirm_email(user).deliver
      end

      Request.to_reconfirm.update_all(pending_reconfirmation: true)
    # rescue
    #   puts "An error occcured while initializing waiting list"
    # end
  end

  # 3. After 48 hours, get all the unreconfirmed request and mark them as expired
  def self.remove_overtime_reconfirmation
    Request.overtimed_confirmation.update_all(status: "expired")
  end

  # accept an existing request
  def accept! id

  end

end

class Booking < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :room
  validates_presence_of :user_id, :start, :end_day, :room_id, on: :create

  scope :with_existing_slot, -> (start_date, end_date) {
    where("? BETWEEN start AND end_day OR ? BETWEEN start AND end_day OR (? <= start AND ? >= end_day)", start_date, end_date, start_date, end_date)
  }

  # validates :status, inclusion: { in: %w( confirmed accepted ) } #{ in: %w( pending confirmed accepted expired ) }

  # not allowed in the waiting list
  # scope :first_come_first_served, -> { order('created_at ASC') }
  # scope :unconfirmed, -> { where(status: 'pending') }
  # scope :confirmed, -> { where(status: 'confirmed') }
  # scope :accepted, -> { where(status: 'accepted') }
  # scope :expired, -> { where(status: 'expired') }

  # # that need to receive a confirmation email
  # scope :to_reconfirm, -> { confirmed
  #                             .where(pending_reconfirmation: false)
  #                             .where("bookings.updated_at < ?", 3.months.ago) }
  #
  # # for which reconfirmation time has expired ( 48h )
  # scope :overtimed_confirmation, -> { confirmed
  #                             .where(pending_reconfirmation: true)
  #                             .where("updated_at < ?", 2.days.ago) }

  # Send pending confirmation email every 3 months
  # def self.send_reconfirmation
  #   begin
  #     User.with_pending_reconfirmation.each do |user|
  #       ApplicationMailer.reconfirm_email(user).deliver
  #       user.booking.update!(pending_reconfirmation: true)
  #     end
  #   rescue => error
  #     puts "An error occcured while initializing waiting list : #{error}"
  #   end
  # end

  # After 48 hours, all unreconfirmed booking are marked as 'expired'
  # def self.clean
  #   puts "cleaning #{Booking.overtimed_confirmation.count} user"
  #   Booking.overtimed_confirmation.update_all!(status: "expired")
  # end
  #
  # def current_position
  #   ids_list = Booking.confirmed
  #                     .map(&:user_id) # :pluck
  #                     .index(self.user_id) + 1
  # end

  def self.to_csv
    attr = %w{ id creation_date status pending_reconfirmation }

    CSV.generate(headers: true) do |csv|
      csv << attr

      all.each do |booking|
        csv << attr.map{ |attr| booking.send(attr) }
      end
    end
  end

  # accept an existing booking if there is a spot left
  # def accept!
  #   if Booking.accepted.count < 20
  #     self.update!(status: 'accepted')
  #   else
  #     puts 'Can not accept this booking, the list is full.'
  #   end
  # end

  private

  def creation_date
    created_at.to_s(:short)
  end

end

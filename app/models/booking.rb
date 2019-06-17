class Booking < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :room
  validates_presence_of :user_id, :start, :end_day, :room_id, on: :create

  scope :start_between, -> (start, finish) { where(start: start..finish) }
  scope :end_between, -> (start, finish) { where(end_day: start..finish) }
  extend Filterable

  def self.with_existing_slot(start, finish)
    arel = Booking.arel_table

    Booking.start_between(start, finish)
           .or(end_between(start, finish))
           .or(
            where(arel[:start].lt(start))
            .where(arel[:end_day].gt(finish))
           )
  end

  def self.to_csv
    attr = %w{ id creation_date status pfinish_reconfirmation }

    CSV.generate(headers: true) do |csv|
      csv << attr

      all.each do |booking|
        csv << attr.map{ |attr| booking.send(attr) }
      end
    end
  end

  private

  def creation_date
    created_at.to_s(:short)
  end

end

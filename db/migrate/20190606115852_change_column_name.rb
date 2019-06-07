class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :end, :end_day
  end
end

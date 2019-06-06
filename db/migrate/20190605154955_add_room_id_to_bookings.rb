class AddRoomIdToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :room_id, :integer
    add_index :bookings, :room_id
  end
end

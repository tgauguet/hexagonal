class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :superficy
      t.string :price
      t.integer :capacity

      t.timestamps
    end
  end
end

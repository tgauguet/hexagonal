class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :status, default: "pending confirmation"
      t.boolean :email_confirmed, default: false
      t.boolean :accepted_in_list, default: false
      t.boolean :pending_reconfirmation, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end

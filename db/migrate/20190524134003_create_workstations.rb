class CreateWorkstations < ActiveRecord::Migration[5.2]
  def change
    create_table :workstations do |t|

      t.timestamps
    end
  end
end

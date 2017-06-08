class CreatePositionShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :position_shifts do |t|
      t.integer :position_id
      t.integer :shift_id
      t.integer :quantity

      t.timestamps
    end
  end
end

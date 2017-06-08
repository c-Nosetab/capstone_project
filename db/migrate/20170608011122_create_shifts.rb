class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.integer :day_of_week
      t.time :time_start
      t.time :time_end
      t.string :title
      t.boolean :is_active?
      t.boolean :is_recurring?
      t.date :date

      t.timestamps
    end
  end
end

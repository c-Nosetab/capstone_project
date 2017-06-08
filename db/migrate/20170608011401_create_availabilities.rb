class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.integer :day_of_week
      t.time :time_start
      t.time :time_end
      t.date :start_date
      t.date :end_date
      t.integer :employee_id

      t.timestamps
    end
  end
end

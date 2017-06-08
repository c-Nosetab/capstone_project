class CreateEmployeeShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_shifts do |t|
      t.integer :employee_id
      t.integer :shift_id

      t.timestamps
    end
  end
end

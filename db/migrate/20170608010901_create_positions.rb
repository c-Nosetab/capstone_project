class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :position_name
      t.integer :company_id

      t.timestamps
    end
  end
end

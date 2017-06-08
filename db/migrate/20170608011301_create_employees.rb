class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :password_digest
      t.boolean :is_admin?
      t.boolean :is_manager?
      t.integer :position_id

      t.timestamps
    end
  end
end

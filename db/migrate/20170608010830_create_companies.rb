class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end

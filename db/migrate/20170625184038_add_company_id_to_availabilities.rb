class AddCompanyIdToAvailabilities < ActiveRecord::Migration[5.1]
  def change
    add_column :availabilities, :company_id, :integer
  end
end

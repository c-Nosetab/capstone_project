class AddCompanyIdToShifts < ActiveRecord::Migration[5.1]
  def change
    add_column :shifts, :company_id, :integer
  end
end

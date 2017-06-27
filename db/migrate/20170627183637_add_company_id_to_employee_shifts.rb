class AddCompanyIdToEmployeeShifts < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_shifts, :company_id, :integer
    add_column :position_shifts, :company_id, :integer
  end
end

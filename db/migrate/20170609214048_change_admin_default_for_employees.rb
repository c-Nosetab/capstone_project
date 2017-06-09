class ChangeAdminDefaultForEmployees < ActiveRecord::Migration[5.1]
  def change
    change_column :employees, :is_admin?, :boolean, default: false
    change_column :employees, :is_manager?, :boolean, default: false

  end
end

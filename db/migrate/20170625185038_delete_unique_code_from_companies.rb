class DeleteUniqueCodeFromCompanies < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :unique_code, :string
  end
end

class AddUniqueCodeToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :unique_code, :string
  end
end

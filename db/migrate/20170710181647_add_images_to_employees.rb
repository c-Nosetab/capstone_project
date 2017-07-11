class AddImagesToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_attachment :employees, :image

  end
end

class AddImageToEmployees < ActiveRecord::Migration[5.1]
  def change

    def self.up
      add_attachment :employees, :image
    end

    def self.down
      remove_attachment :employees, :image
    end

  end
end

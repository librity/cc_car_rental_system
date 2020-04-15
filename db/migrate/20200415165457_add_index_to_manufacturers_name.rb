class AddIndexToManufacturersName < ActiveRecord::Migration[6.0]
  def change
    add_index :manufacturers, :name, unique: true
  end
end

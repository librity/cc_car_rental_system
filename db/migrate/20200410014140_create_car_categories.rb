class CreateCarCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :car_categories do |t|
      t.string :name
      t.float :daily_rate
      t.float :insurance
      t.float :third_party_insurance

      t.timestamps
    end
  end
end

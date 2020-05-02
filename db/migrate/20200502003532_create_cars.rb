# frozen_string_literal: true

class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :license_plate
      t.string :color
      t.integer :metric_milage
      t.references :car_model, null: false, foreign_key: true
      t.references :subsidiary, null: false, foreign_key: true

      t.timestamps
    end

    add_index :cars, :license_plate, unique: true
  end
end

# frozen_string_literal: true

class CreateCarModels < ActiveRecord::Migration[6.0]
  def change
    create_table :car_models do |t|
      t.string :name
      t.string :year
      t.string :metric_horsepower
      t.string :fuel_type
      t.integer :metric_city_milage
      t.integer :metric_highway_milage

      t.references :car_category, null: false, foreign_key: true
      t.references :manufacturer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

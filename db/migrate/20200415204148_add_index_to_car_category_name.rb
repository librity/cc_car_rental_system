# frozen_string_literal: true

class AddIndexToCarCategoryName < ActiveRecord::Migration[6.0]
  def change
    add_index :car_categories, :name, unique: true
  end
end

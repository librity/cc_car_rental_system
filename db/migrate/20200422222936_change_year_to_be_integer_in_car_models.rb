# frozen_string_literal: true

class ChangeYearToBeIntegerInCarModels < ActiveRecord::Migration[6.0]
  def up
    change_column :car_models, :year, :integer
  end

  def down
    change_column :car_models, :year, :string
  end
end

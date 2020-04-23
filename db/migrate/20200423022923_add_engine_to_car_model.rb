# frozen_string_literal: true

class AddEngineToCarModel < ActiveRecord::Migration[6.0]
  def change
    add_column :car_models, :engine, :string
  end
end

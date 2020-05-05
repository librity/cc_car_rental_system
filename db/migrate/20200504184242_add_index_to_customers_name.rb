# frozen_string_literal: true

class AddIndexToCustomersName < ActiveRecord::Migration[6.0]
  def change
    add_index :customers, :name, unique: false
  end
end

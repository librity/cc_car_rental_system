# frozen_string_literal: true

class AddTokenToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :token, :string

    add_index :rentals, :token, unique: true
  end
end

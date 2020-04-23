# frozen_string_literal: true

class AddIndexToCustomerEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :customers, :email, unique: true

  end
end

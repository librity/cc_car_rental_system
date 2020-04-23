# frozen_string_literal: true

class AddIndexToSubsidiaryName < ActiveRecord::Migration[6.0]
  def change
    add_index :subsidiaries, :name, unique: true
  end
end

# frozen_string_literal: true

class AddIndexToSubsidiaryCnpj < ActiveRecord::Migration[6.0]
  def change
    add_index :subsidiaries, :cnpj, unique: true
  end
end

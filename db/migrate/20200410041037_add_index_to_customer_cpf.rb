# frozen_string_literal: true

class AddIndexToCustomerCpf < ActiveRecord::Migration[6.0]
  def change
    add_index :customers, :cpf, unique: true
  end
end

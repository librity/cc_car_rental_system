# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :cpf, presence: true, length: { is: 11 }, uniqueness: true,
                  numericality: { only_integer: true }, cpf: true
end

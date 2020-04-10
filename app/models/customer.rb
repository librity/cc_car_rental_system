# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :cpf, presence: true, length: { is: 11 }, uniqueness: true,
                  cpf: true
end

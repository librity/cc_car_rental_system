# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :cpf, presence: { message: 'Cpf não pode ficar em branco' },
                  uniqueness: { message: 'Cpf deve ser único' },
                  cpf: { message: 'Cpf não é valido' },
                  length: { is: 11 },  numericality: { only_integer: true }
end

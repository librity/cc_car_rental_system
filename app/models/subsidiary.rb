# frozen_string_literal: true

class Subsidiary < ApplicationRecord
  validates :cnpj, presence: { message: 'Cnpj não pode ficar em branco' },
                   uniqueness: { message: 'Cnpj deve ser único' },
                   cnpj: { message: 'Cnpj não é valido' },
                   length: { is: 14 }, numericality: { only_integer: true }
end

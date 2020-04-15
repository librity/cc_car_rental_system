# frozen_string_literal: true

class Subsidiary < ApplicationRecord
  validates :name, presence: { message: 'Nome não pode ficar em branco' },
                   uniqueness: { message: 'Nome deve ser único' }
  validates :cnpj, presence: { message: 'Cnpj não pode ficar em branco' },
                   uniqueness: { message: 'Cnpj deve ser único' },
                   cnpj: { message: 'Cnpj não é valido' },
                   length: { is: 14 }, numericality: { only_integer: true }
end

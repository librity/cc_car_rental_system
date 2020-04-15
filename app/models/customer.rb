# frozen_string_literal: true

class Customer < ApplicationRecord
  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :email, presence: { message: 'Email não pode ficar em branco' },
                    uniqueness: { message: 'Email deve ser único' },
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'Email não é valido' }
  validates :cpf, presence: { message: 'Cpf não pode ficar em branco' },
                  uniqueness: { message: 'Cpf deve ser único' },
                  cpf: { message: 'Cpf não é valido' },
                  length: { is: 11 },  numericality: { only_integer: true }
end

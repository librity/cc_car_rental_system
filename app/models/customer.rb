# frozen_string_literal: true

class Customer < ApplicationRecord
  before_save { email.downcase! }

  validates :name, presence: { message: I18n.t('models.validations.name.not_empty') }
  validates :email, presence: { message: 'Email não pode ficar em branco' },
                    uniqueness: { message: 'Email deve ser único' },
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'Email não é valido' },
                    length: { maximum: 255, message: 'Email muito longo' }
  validates :cpf, presence: { message: 'Cpf não pode ficar em branco' },
                  uniqueness: { message: 'Cpf deve ser único' },
                  cpf: { message: 'Cpf não é valido' },
                  length: { is: 11 },  numericality: { only_integer: true }
end

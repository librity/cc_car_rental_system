# frozen_string_literal: true

class Subsidiary < ApplicationRecord
  validates :name, presence: { message: I18n.t('models.validations.name.not_empty') },
                   uniqueness: { message: I18n.t('models.validations.name.unique') }
  validates :cnpj, presence: { message: 'Cnpj não pode ficar em branco' },
                   uniqueness: { message: 'Cnpj deve ser único' },
                   cnpj: { message: 'Cnpj não é valido' },
                   length: { is: 14 }, numericality: { only_integer: true }
end

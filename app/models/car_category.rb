# frozen_string_literal: true

class CarCategory < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: { message: I18n.t('models.validations.name.not_empty') },
                   uniqueness: { message: I18n.t('models.validations.name.unique') }
end

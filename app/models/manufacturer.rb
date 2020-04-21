# frozen_string_literal: true

class Manufacturer < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: { message: I18n.t('models.validations.not_empty', attribute: I18n.t('views.labels.name')) },
                   uniqueness: { message: I18n.t('models.validations.unique', attribute: I18n.t('views.labels.name')) }
end

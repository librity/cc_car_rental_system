# frozen_string_literal: true

class CarCategory < ApplicationRecord
  has_many :car_models, dependent: :destroy

  validates :name, presence: { message: 'Nome não pode ficar em branco' },
                   uniqueness: { message: 'Nome deve ser único' }
end

# frozen_string_literal: true

class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category

  validates :name, presence: { message: 'Nome não pode ficar em branco' }
  validates :year, presence: { message: 'Ano não pode ficar em branco' },
                   numericality: { only_integer: true,
                                   message: 'Ano tem que ser um número inteiro' },
                   length: { is: 4, message: 'Ano tem que ter 4 digitos' }
  validates :manufacturer, presence: { message: 'Fabricante não pode ficar em branco' }
  validates :metric_horsepower, presence: { message: 'Potência não pode ficar em branco' }
  validates :car_category, presence: { message: 'Categoria de veículo não pode ficar em branco' }
  validates :fuel_type, presence: { message: 'Tipo de combustível não pode ficar em branco' }
  validates :metric_city_milage,
            presence: { message: 'Quilometragem na cidade não pode ficar em branco' },
            numericality: { only_integer: true,
                            message: 'Quilometragem na cidade tem que ser um número inteiro' }
  validates :metric_highway_milage,
            presence: { message: 'Quilometragem na estrada não pode ficar em branco' },
            numericality: { only_integer: true,
                            message: 'Quilometragem na estrada tem que ser um número inteiro' }
end

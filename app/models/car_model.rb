# frozen_string_literal: true

class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :car_category

  validates :name, presence: true
  validates :year, presence: true, numericality: { only_integer: true },
                   length: { is: 4 }
  validates :manufacturer, presence: true
  validates :metric_horsepower, presence: true
  validates :car_category, presence: true
  validates :fuel_type, presence: true
  validates :metric_city_milage, numericality: { only_integer: true },
                                 presence: true
  validates :metric_highway_milage, numericality: { only_integer: true },
                                    presence: true
end

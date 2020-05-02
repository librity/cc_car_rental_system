# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  validates :license_plate, presence: true, uniqueness: true
  validates :color, presence: true
  validates :metric_milage, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
                            presence: true
  validates :car_model, presence: true
  validates :subsidiary, presence: true
end

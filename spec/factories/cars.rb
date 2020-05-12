# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    license_plate { 'ABC1234' }
    color { 'Branco' }
    milage { 0 }
    car_model
  end
end
